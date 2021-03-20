Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF1342E2D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCTQJE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 12:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhCTQIp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 12:08:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1596061878;
        Sat, 20 Mar 2021 16:08:42 +0000 (UTC)
Date:   Sat, 20 Mar 2021 16:08:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] iio: event_monitor: Enable events before monitoring
Message-ID: <20210320160840.1db3e627@jic23-huawei>
In-Reply-To: <20210319135301.542911-1-linus.walleij@linaro.org>
References: <20210319135301.542911-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 14:53:01 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> After some painful sessions with a driver that register an
> enable/disable sysfs knob (gp2ap002) and manually going
> in and enabling the event before monitoring it:
> 
>   cd /sys/bus/iio/devices/iio\:device2/events
>   # ls
>   in_proximity_thresh_either_en
>   # echo 1 > in_proximity_thresh_either_en
> 
> I realized that it's better if the iio_event_monitor is
> smart enough to enable all events by itself and disable them
> after use, if passed the -a flag familiar from the
> iio_generic_buffer tool.
> 
> Auto-enabling events depend on the hardware being able
> to handle all events at the same time which isn't
> necessarily the case, so a command line option is required
> for this.
> 
> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus

This crossed with some changes in the header reflecting the
new buffer structure (example is not using the compatible
old form which is still there).  Added a bit of fuzz but
nothing that looks significant.

Applied to the togreg branch of iio.git and pushed out as testing,
though I've no idea if the autobuilders even build tools/*

Thanks,

Jonathan

> ---
> ChangeLog v1->v2:
> - Activate all events in response to -a being passed
>   on the command line
> - Update help text
> ---
>  tools/iio/iio_event_monitor.c | 69 ++++++++++++++++++++++++++++++++---
>  tools/iio/iio_utils.h         |  1 +
>  2 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index bb03859db89d..0076437f6e3f 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -14,6 +14,7 @@
>  
>  #include <unistd.h>
>  #include <stdlib.h>
> +#include <dirent.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -280,22 +281,69 @@ static void print_event(struct iio_event_data *event)
>  	printf("\n");
>  }
>  
> +/* Enable or disable events in sysfs if the knob is available */
> +static void enable_events(char *dev_dir, int enable)
> +{
> +	const struct dirent *ent;
> +	char evdir[256];
> +	int ret;
> +	DIR *dp;
> +
> +	snprintf(evdir, sizeof(evdir), FORMAT_EVENTS_DIR, dev_dir);
> +	evdir[sizeof(evdir)-1] = '\0';
> +
> +	dp = opendir(evdir);
> +	if (!dp) {
> +		fprintf(stderr, "Enabling/disabling events: can't open %s\n",
> +			evdir);
> +		return;
> +	}
> +
> +	while (ent = readdir(dp), ent) {
> +		if (iioutils_check_suffix(ent->d_name, "_en")) {
> +			printf("%sabling: %s\n",
> +			       enable ? "En" : "Dis",
> +			       ent->d_name);
> +			ret = write_sysfs_int(ent->d_name, evdir,
> +					      enable);
> +			if (ret < 0)
> +				fprintf(stderr, "Failed to enable/disable %s\n",
> +					ent->d_name);
> +		}
> +	}
> +
> +	if (closedir(dp) == -1) {
> +		perror("Enabling/disabling channels: "
> +		       "Failed to close directory");
> +		return;
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	struct iio_event_data event;
>  	const char *device_name;
> +	char *dev_dir_name = NULL;
>  	char *chrdev_name;
>  	int ret;
>  	int dev_num;
>  	int fd, event_fd;
> -
> -	if (argc <= 1) {
> -		fprintf(stderr, "Usage: %s <device_name>\n", argv[0]);
> +	bool all_events = false;
> +
> +	if (argc == 2) {
> +		device_name = argv[1];
> +	} else if (argc == 3) {
> +		device_name = argv[2];
> +		if (!strcmp(argv[1], "-a"))
> +			all_events = true;
> +	} else {
> +		fprintf(stderr,
> +			"Usage: iio_event_monitor [options] <device_name>\n"
> +			"Listen and display events from IIO devices\n"
> +			"  -a         Auto-activate all available events\n");
>  		return -1;
>  	}
>  
> -	device_name = argv[1];
> -
>  	dev_num = find_type_by_name(device_name, "iio:device");
>  	if (dev_num >= 0) {
>  		printf("Found IIO device with name %s with device number %d\n",
> @@ -303,6 +351,10 @@ int main(int argc, char **argv)
>  		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
>  		if (ret < 0)
>  			return -ENOMEM;
> +		/* Look up sysfs dir as well if we can */
> +		ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> +		if (ret < 0)
> +			return -ENOMEM;
>  	} else {
>  		/*
>  		 * If we can't find an IIO device by name assume device_name is
> @@ -313,6 +365,9 @@ int main(int argc, char **argv)
>  			return -ENOMEM;
>  	}
>  
> +	if (all_events && dev_dir_name)
> +		enable_events(dev_dir_name, 1);
> +
>  	fd = open(chrdev_name, 0);
>  	if (fd == -1) {
>  		ret = -errno;
> @@ -365,6 +420,10 @@ int main(int argc, char **argv)
>  		perror("Failed to close event file");
>  
>  error_free_chrdev_name:
> +	/* Disable events after use */
> +	if (all_events && dev_dir_name)
> +		enable_events(dev_dir_name, 0);
> +
>  	free(chrdev_name);
>  
>  	return ret;
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 74bde4fde2c8..c01695049739 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,6 +13,7 @@
>  #define IIO_MAX_NAME_LENGTH 64
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> +#define FORMAT_EVENTS_DIR "%s/events"
>  #define FORMAT_TYPE_FILE "%s_type"
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))

