Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1731BA99
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 14:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBONxu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 08:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhBONxH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 08:53:07 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B32600CF;
        Mon, 15 Feb 2021 13:52:22 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:52:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v6 24/24] tools: iio: convert iio_generic_buffer to use
 new IIO buffer API
Message-ID: <20210215135219.2cfeb840@archlinux>
In-Reply-To: <20210215104043.91251-25-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-25-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 12:40:43 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change makes use of the new IIO buffer API to read data from an IIO
> buffer.
> It doesn't read the /sys/bus/iio/devices/iio:deviceX/scan_elements dir
> anymore, it reads /sys/bus/iio/devices/iio:deviceX/bufferY, where all the
> scan_elements have been merged together with the old/classical buffer
> attributes.
> 
> And it makes use of the new IIO_BUFFER_GET_FD_IOCTL ioctl to get an FD for
> the IIO buffer for which to read data from.
> It also does a quick sanity check to see that -EBUSY is returned if reading
> the chardev after the ioctl() has succeeded.
> 
> This was tested with the following cases:
>  1. Tested buffer0 works with ioctl()
>  2. Tested that buffer0 can't be opened via /dev/iio:deviceX after ioctl()
>     This check should be omitted under normal operation; it's being done
>     here to check that the driver change is sane
>  3. Moved valid buffer0 to be buffer1, and tested that data comes from it
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Whole series applied to the togreg branch of iio.git and pushed out as testing
to see what we missed in review.

There is that one patch doing rework of a load of drivers early on in the
series that may get a few more reviews.

Otherwise, reviews on any of this from others still definitely welcome.
I'm not going to push out as a non rebasing tree for at least a couple of
weeks (given merge window is open).

Thanks,

Jonathan

> ---
>  tools/iio/Makefile             |   1 +
>  tools/iio/iio_generic_buffer.c | 122 ++++++++++++++++++++++++++-------
>  tools/iio/iio_utils.c          |  13 ++--
>  tools/iio/iio_utils.h          |   4 +-
>  4 files changed, 107 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 3de763d9ab70..5d12ac4e7f8f 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -27,6 +27,7 @@ include $(srctree)/tools/build/Makefile.include
>  #
>  $(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
>  	mkdir -p $(OUTPUT)include/linux/iio 2>&1 || true
> +	ln -sf $(CURDIR)/../../include/uapi/linux/iio/buffer.h $@
>  	ln -sf $(CURDIR)/../../include/uapi/linux/iio/events.h $@
>  	ln -sf $(CURDIR)/../../include/uapi/linux/iio/types.h $@
>  
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 7c7240553777..2491c54a5e4f 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -30,6 +30,8 @@
>  #include <inttypes.h>
>  #include <stdbool.h>
>  #include <signal.h>
> +#include <sys/ioctl.h>
> +#include <linux/iio/buffer.h>
>  #include "iio_utils.h"
>  
>  /**
> @@ -197,7 +199,7 @@ static void process_scan(char *data, struct iio_channel_info *channels,
>  	printf("\n");
>  }
>  
> -static int enable_disable_all_channels(char *dev_dir_name, int enable)
> +static int enable_disable_all_channels(char *dev_dir_name, int buffer_idx, int enable)
>  {
>  	const struct dirent *ent;
>  	char scanelemdir[256];
> @@ -205,7 +207,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
>  	int ret;
>  
>  	snprintf(scanelemdir, sizeof(scanelemdir),
> -		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name);
> +		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name, buffer_idx);
>  	scanelemdir[sizeof(scanelemdir)-1] = '\0';
>  
>  	dp = opendir(scanelemdir);
> @@ -243,6 +245,7 @@ static void print_usage(void)
>  		"Capture, convert and output data from IIO device buffer\n"
>  		"  -a         Auto-activate all available channels\n"
>  		"  -A         Force-activate ALL channels\n"
> +		"  -b <n>     The buffer which to open (by index), default 0\n"
>  		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
> @@ -259,6 +262,7 @@ static void print_usage(void)
>  static enum autochan autochannels = AUTOCHANNELS_DISABLED;
>  static char *dev_dir_name = NULL;
>  static char *buf_dir_name = NULL;
> +static int buffer_idx = 0;
>  static bool current_trigger_set = false;
>  
>  static void cleanup(void)
> @@ -286,7 +290,7 @@ static void cleanup(void)
>  
>  	/* Disable channels if auto-enabled */
>  	if (dev_dir_name && autochannels == AUTOCHANNELS_ACTIVE) {
> -		ret = enable_disable_all_channels(dev_dir_name, 0);
> +		ret = enable_disable_all_channels(dev_dir_name, buffer_idx, 0);
>  		if (ret)
>  			fprintf(stderr, "Failed to disable all channels\n");
>  		autochannels = AUTOCHANNELS_DISABLED;
> @@ -333,7 +337,9 @@ int main(int argc, char **argv)
>  	unsigned long long j;
>  	unsigned long toread;
>  	int ret, c;
> -	int fp = -1;
> +	struct stat st;
> +	int fd = -1;
> +	int buf_fd = -1;
>  
>  	int num_channels = 0;
>  	char *trigger_name = NULL, *device_name = NULL;
> @@ -352,7 +358,7 @@ int main(int argc, char **argv)
>  
>  	register_cleanup();
>  
> -	while ((c = getopt_long(argc, argv, "aAc:egl:n:N:t:T:w:?", longopts,
> +	while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
>  				NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
> @@ -361,7 +367,20 @@ int main(int argc, char **argv)
>  		case 'A':
>  			autochannels = AUTOCHANNELS_ENABLED;
>  			force_autochannels = true;
> -			break;	
> +			break;
> +		case 'b':
> +			errno = 0;
> +			buffer_idx = strtoll(optarg, &dummy, 10);
> +			if (errno) {
> +				ret = -errno;
> +				goto error;
> +			}
> +			if (buffer_idx < 0) {
> +				ret = -ERANGE;
> +				goto error;
> +			}
> +
> +			break;
>  		case 'c':
>  			errno = 0;
>  			num_loops = strtoll(optarg, &dummy, 10);
> @@ -518,7 +537,7 @@ int main(int argc, char **argv)
>  	 * Parse the files in scan_elements to identify what channels are
>  	 * present
>  	 */
> -	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
> +	ret = build_channel_array(dev_dir_name, buffer_idx, &channels, &num_channels);
>  	if (ret) {
>  		fprintf(stderr, "Problem reading scan element information\n"
>  			"diag %s\n", dev_dir_name);
> @@ -535,7 +554,7 @@ int main(int argc, char **argv)
>  	    (autochannels == AUTOCHANNELS_ENABLED && force_autochannels)) {
>  		fprintf(stderr, "Enabling all channels\n");
>  
> -		ret = enable_disable_all_channels(dev_dir_name, 1);
> +		ret = enable_disable_all_channels(dev_dir_name, buffer_idx, 1);
>  		if (ret) {
>  			fprintf(stderr, "Failed to enable all channels\n");
>  			goto error;
> @@ -544,7 +563,7 @@ int main(int argc, char **argv)
>  		/* This flags that we need to disable the channels again */
>  		autochannels = AUTOCHANNELS_ACTIVE;
>  
> -		ret = build_channel_array(dev_dir_name, &channels,
> +		ret = build_channel_array(dev_dir_name, buffer_idx, &channels,
>  					  &num_channels);
>  		if (ret) {
>  			fprintf(stderr, "Problem reading scan element "
> @@ -565,7 +584,7 @@ int main(int argc, char **argv)
>  		fprintf(stderr, "Enable channels manually in "
>  			FORMAT_SCAN_ELEMENTS_DIR
>  			"/*_en or pass -a to autoenable channels and "
> -			"try again.\n", dev_dir_name);
> +			"try again.\n", dev_dir_name, buffer_idx);
>  		ret = -ENOENT;
>  		goto error;
>  	}
> @@ -576,12 +595,25 @@ int main(int argc, char **argv)
>  	 * be built rather than found.
>  	 */
>  	ret = asprintf(&buf_dir_name,
> -		       "%siio:device%d/buffer", iio_dir, dev_num);
> +		       "%siio:device%d/buffer%d", iio_dir, dev_num, buffer_idx);
>  	if (ret < 0) {
>  		ret = -ENOMEM;
>  		goto error;
>  	}
>  
> +	if (stat(buf_dir_name, &st)) {
> +		fprintf(stderr, "Could not stat() '%s', got error %d: %s\n",
> +			buf_dir_name, errno, strerror(errno));
> +		ret = -errno;
> +		goto error;
> +	}
> +
> +	if (!S_ISDIR(st.st_mode)) {
> +		fprintf(stderr, "File '%s' is not a directory\n", buf_dir_name);
> +		ret = -EFAULT;
> +		goto error;
> +	}
> +
>  	if (!notrigger) {
>  		printf("%s %s\n", dev_dir_name, trigger_name);
>  		/*
> @@ -598,6 +630,35 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> +	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Attempt to open non blocking the access dev */
> +	fd = open(buffer_access, O_RDONLY | O_NONBLOCK);
> +	if (fd == -1) { /* TODO: If it isn't there make the node */
> +		ret = -errno;
> +		fprintf(stderr, "Failed to open %s\n", buffer_access);
> +		goto error;
> +	}
> +
> +	/* specify for which buffer index we want an FD */
> +	buf_fd = buffer_idx;
> +
> +	ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &buf_fd);
> +	if (ret == -1 || buf_fd == -1) {
> +		ret = -errno;
> +		if (ret == -ENODEV || ret == -EINVAL)
> +			fprintf(stderr,
> +				"Device does not have this many buffers\n");
> +		else
> +			fprintf(stderr, "Failed to retrieve buffer fd\n");
> +
> +		goto error;
> +	}
> +
>  	/* Setup ring buffer parameters */
>  	ret = write_sysfs_int("length", buf_dir_name, buf_len);
>  	if (ret < 0)
> @@ -607,7 +668,8 @@ int main(int argc, char **argv)
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>  	if (ret < 0) {
>  		fprintf(stderr,
> -			"Failed to enable buffer: %s\n", strerror(-ret));
> +			"Failed to enable buffer '%s': %s\n",
> +			buf_dir_name, strerror(-ret));
>  		goto error;
>  	}
>  
> @@ -618,24 +680,30 @@ int main(int argc, char **argv)
>  		goto error;
>  	}
>  
> -	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error;
> +	/**
> +	 * This check is being done here for sanity reasons, however it
> +	 * should be omitted under normal operation.
> +	 * If this is buffer0, we check that we get EBUSY after this point.
> +	 */
> +	if (buffer_idx == 0) {
> +		errno = 0;
> +		read_size = read(fd, data, 1);
> +		if (read_size > -1 || errno != EBUSY) {
> +			ret = -EFAULT;
> +			perror("Reading from '%s' should not be possible after ioctl()");
> +			goto error;
> +		}
>  	}
>  
> -	/* Attempt to open non blocking the access dev */
> -	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
> -	if (fp == -1) { /* TODO: If it isn't there make the node */
> -		ret = -errno;
> -		fprintf(stderr, "Failed to open %s\n", buffer_access);
> -		goto error;
> -	}
> +	/* close now the main chardev FD and let the buffer FD work */
> +	if (close(fd) == -1)
> +		perror("Failed to close character device file");
> +	fd = -1;
>  
>  	for (j = 0; j < num_loops || num_loops < 0; j++) {
>  		if (!noevents) {
>  			struct pollfd pfd = {
> -				.fd = fp,
> +				.fd = buf_fd,
>  				.events = POLLIN,
>  			};
>  
> @@ -653,7 +721,7 @@ int main(int argc, char **argv)
>  			toread = 64;
>  		}
>  
> -		read_size = read(fp, data, toread * scan_size);
> +		read_size = read(buf_fd, data, toread * scan_size);
>  		if (read_size < 0) {
>  			if (errno == EAGAIN) {
>  				fprintf(stderr, "nothing available\n");
> @@ -670,7 +738,9 @@ int main(int argc, char **argv)
>  error:
>  	cleanup();
>  
> -	if (fp >= 0 && close(fp) == -1)
> +	if (fd >= 0 && close(fd) == -1)
> +		perror("Failed to close character device");
> +	if (buf_fd >= 0 && close(buf_fd) == -1)
>  		perror("Failed to close buffer");
>  	free(buffer_access);
>  	free(data);
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index a96002f2c2d5..aadee6d34c74 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -77,6 +77,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
>   * @mask: output a bit mask for the raw data
>   * @be: output if data in big endian
>   * @device_dir: the IIO device directory
> + * @buffer_idx: the IIO buffer index
>   * @name: the channel name
>   * @generic_name: the channel type name
>   *
> @@ -85,8 +86,8 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
>  static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
>  			     unsigned int *bits_used, unsigned int *shift,
>  			     uint64_t *mask, unsigned int *be,
> -			     const char *device_dir, const char *name,
> -			     const char *generic_name)
> +			     const char *device_dir, int buffer_idx,
> +			     const char *name, const char *generic_name)
>  {
>  	FILE *sysfsfp;
>  	int ret;
> @@ -96,7 +97,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
>  	unsigned padint;
>  	const struct dirent *ent;
>  
> -	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> +	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir, buffer_idx);
>  	if (ret < 0)
>  		return -ENOMEM;
>  
> @@ -304,12 +305,13 @@ void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
>  /**
>   * build_channel_array() - function to figure out what channels are present
>   * @device_dir: the IIO device directory in sysfs
> + * @buffer_idx: the IIO buffer for this channel array
>   * @ci_array: output the resulting array of iio_channel_info
>   * @counter: output the amount of array elements
>   *
>   * Returns 0 on success, otherwise a negative error code.
>   **/
> -int build_channel_array(const char *device_dir,
> +int build_channel_array(const char *device_dir, int buffer_idx,
>  			struct iio_channel_info **ci_array, int *counter)
>  {
>  	DIR *dp;
> @@ -322,7 +324,7 @@ int build_channel_array(const char *device_dir,
>  	char *filename;
>  
>  	*counter = 0;
> -	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> +	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir, buffer_idx);
>  	if (ret < 0)
>  		return -ENOMEM;
>  
> @@ -503,6 +505,7 @@ int build_channel_array(const char *device_dir,
>  						&current->mask,
>  						&current->be,
>  						device_dir,
> +						buffer_idx,
>  						current->name,
>  						current->generic_name);
>  			if (ret < 0)
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index a5d0aa8a57d3..336752cade4f 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -12,7 +12,7 @@
>  /* Made up value to limit allocation sizes */
>  #define IIO_MAX_NAME_LENGTH 64
>  
> -#define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> +#define FORMAT_SCAN_ELEMENTS_DIR "%s/buffer%d"
>  #define FORMAT_TYPE_FILE "%s_type"
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
> @@ -61,7 +61,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
>  			     const char *device_dir, const char *name,
>  			     const char *generic_name);
>  void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt);
> -int build_channel_array(const char *device_dir,
> +int build_channel_array(const char *device_dir, int buffer_idx,
>  			struct iio_channel_info **ci_array, int *counter);
>  int find_type_by_name(const char *name, const char *type);
>  int write_sysfs_int(const char *filename, const char *basedir, int val);

