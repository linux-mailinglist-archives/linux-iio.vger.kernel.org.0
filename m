Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0032D742
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 17:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhCDQBY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Mar 2021 11:01:24 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42927 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhCDQAx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Mar 2021 11:00:53 -0500
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8BDD81C0002;
        Thu,  4 Mar 2021 16:00:00 +0000 (UTC)
Message-ID: <969d00d5ea1e2d575a8464bebef4a8f16285ed98.camel@hadess.net>
Subject: Re: [PATCH] iio: event_monitor: Enable events before monitoring
From:   Bastien Nocera <hadess@hadess.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date:   Thu, 04 Mar 2021 16:59:59 +0100
In-Reply-To: <20210304154205.1918124-1-linus.walleij@linaro.org>
References: <20210304154205.1918124-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2021-03-04 at 16:42 +0100, Linus Walleij wrote:
> After some painful sessions with a driver that register an
> enable/disable sysfs knob (gp2ap002) and manually going
> in and enabling the event before monitoring it:
> 
>   cd /sys/bus/iio/devices/iio\:device2/events
>   # ls
>   in_proximity_thresh_either_en
>   # echo 1 > in_proximity_thresh_either_en
> 
> I realized that it's better if the iio_event_monitor is
> smart enough to enable all events by itself and disable them
> after use.
> 
> I didn't add a command line option for this, to me it
> seems pretty intuitive and mostly what you want the tool
> to do for you.
> 
> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

If I'm not mistaken, "-a" does that for the iio_generic_buffer tool.

Maybe moving enable_disable_all_channels() to a common location and
using that would cut down on the duplicated code?

> ---
> Bastien: added you on CC FYI because I suppose maybe
> iio-sensor-proxy isn't yet doing this and one day people
> will wonder why their events aren't arriving.
> ---
>  tools/iio/iio_event_monitor.c | 51
> +++++++++++++++++++++++++++++++++++
>  tools/iio/iio_utils.h         |  1 +
>  2 files changed, 52 insertions(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c
> b/tools/iio/iio_event_monitor.c
> index bb03859db89d..27778fe28f82 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -14,6 +14,7 @@
>  
>  #include <unistd.h>
>  #include <stdlib.h>
> +#include <dirent.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -280,10 +281,49 @@ static void print_event(struct iio_event_data
> *event)
>         printf("\n");
>  }
>  
> +/* Enable or disable events in sysfs if the knob is available */
> +static void enable_events(char *dev_dir, int enable)
> +{
> +       const struct dirent *ent;
> +       char evdir[256];
> +       int ret;
> +       DIR *dp;
> +
> +       snprintf(evdir, sizeof(evdir), FORMAT_EVENTS_DIR, dev_dir);
> +       evdir[sizeof(evdir)-1] = '\0';
> +
> +       dp = opendir(evdir);
> +       if (!dp) {
> +               fprintf(stderr, "Enabling/disabling events: can't
> open %s\n",
> +                       evdir);
> +               return;
> +       }
> +
> +       while (ent = readdir(dp), ent) {
> +               if (iioutils_check_suffix(ent->d_name, "_en")) {
> +                       printf("%sabling: %s\n",
> +                              enable ? "En" : "Dis",
> +                              ent->d_name);
> +                       ret = write_sysfs_int(ent->d_name, evdir,
> +                                             enable);
> +                       if (ret < 0)
> +                               fprintf(stderr, "Failed to
> enable/disable %s\n",
> +                                       ent->d_name);
> +               }
> +       }
> +
> +       if (closedir(dp) == -1) {
> +               perror("Enabling/disabling channels: "
> +                      "Failed to close directory");
> +               return;
> +       }
> +}
> +
>  int main(int argc, char **argv)
>  {
>         struct iio_event_data event;
>         const char *device_name;
> +       char *dev_dir_name = NULL;
>         char *chrdev_name;
>         int ret;
>         int dev_num;
> @@ -303,6 +343,10 @@ int main(int argc, char **argv)
>                 ret = asprintf(&chrdev_name, "/dev/iio:device%d",
> dev_num);
>                 if (ret < 0)
>                         return -ENOMEM;
> +               /* Look up sysfs dir as well if we can */
> +               ret = asprintf(&dev_dir_name, "%siio:device%d",
> iio_dir, dev_num);
> +               if (ret < 0)
> +                       return -ENOMEM;
>         } else {
>                 /*
>                  * If we can't find an IIO device by name assume
> device_name is
> @@ -313,6 +357,9 @@ int main(int argc, char **argv)
>                         return -ENOMEM;
>         }
>  
> +       if (dev_dir_name)
> +               enable_events(dev_dir_name, 1);
> +
>         fd = open(chrdev_name, 0);
>         if (fd == -1) {
>                 ret = -errno;
> @@ -365,6 +412,10 @@ int main(int argc, char **argv)
>                 perror("Failed to close event file");
>  
>  error_free_chrdev_name:
> +       /* Disable events after use */
> +       if (dev_dir_name)
> +               enable_events(dev_dir_name, 0);
> +
>         free(chrdev_name);
>  
>         return ret;
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 74bde4fde2c8..c01695049739 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,6 +13,7 @@
>  #define IIO_MAX_NAME_LENGTH 64
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> +#define FORMAT_EVENTS_DIR "%s/events"
>  #define FORMAT_TYPE_FILE "%s_type"
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))


