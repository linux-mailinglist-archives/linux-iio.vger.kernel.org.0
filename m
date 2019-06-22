Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA4F4D5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFVJnH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVJnH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:43:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FCC2084E;
        Sat, 22 Jun 2019 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561196585;
        bh=t+jdhrtqnAeVSdTIuwqh5S0S8lqQudNzmmkSgt8+mNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkqDoDMQ8Tfy9zCFMuN2FS6chXTfNjoDIFZ8bO5yQW0Eamu0RIeew/hoHwQuMgbPH
         uo4iewCHBEkJmzYmErZgwDR6Kw1lfwogjQXJQjOLMRGtqkSANbxXyPYQz+PRDvKLll
         i5ZADS5Pu/wJgu+cuFQ5LVpfonRPSSWg1wqQRkVE=
Date:   Sat, 22 Jun 2019 10:43:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 22/29] docs: iio: convert to ReST
Message-ID: <20190622104300.6ff9e871@archlinux>
In-Reply-To: <f54094f023f1ab7130af64ffdbe4bc4cf66452b9.1560890801.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
        <f54094f023f1ab7130af64ffdbe4bc4cf66452b9.1560890801.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 17:53:40 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Rename the iio documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'll take this via IIO.

Applied to the togreg branch of iio.git and pushed out as testing.
I'll probably do a pull request to Greg tomorrow and these will hopefully
turn up in linux-next not long after that.

Thanks Mauro!

Jonathan

> ---
>  .../iio/{ep93xx_adc.txt => ep93xx_adc.rst}    | 15 +++++-
>  .../{iio_configfs.txt => iio_configfs.rst}    | 52 +++++++++++--------
>  Documentation/iio/index.rst                   | 12 +++++
>  drivers/iio/Kconfig                           |  2 +-
>  4 files changed, 56 insertions(+), 25 deletions(-)
>  rename Documentation/iio/{ep93xx_adc.txt => ep93xx_adc.rst} (71%)
>  rename Documentation/iio/{iio_configfs.txt => iio_configfs.rst} (73%)
>  create mode 100644 Documentation/iio/index.rst
> 
> diff --git a/Documentation/iio/ep93xx_adc.txt b/Documentation/iio/ep93xx_adc.rst
> similarity index 71%
> rename from Documentation/iio/ep93xx_adc.txt
> rename to Documentation/iio/ep93xx_adc.rst
> index 23053e7817bd..4fd8dea3f6b8 100644
> --- a/Documentation/iio/ep93xx_adc.txt
> +++ b/Documentation/iio/ep93xx_adc.rst
> @@ -1,12 +1,16 @@
> -Cirrus Logic EP93xx ADC driver.
> +==============================
> +Cirrus Logic EP93xx ADC driver
> +==============================
>  
>  1. Overview
> +===========
>  
>  The driver is intended to work on both low-end (EP9301, EP9302) devices with
>  5-channel ADC and high-end (EP9307, EP9312, EP9315) devices with 10-channel
>  touchscreen/ADC module.
>  
>  2. Channel numbering
> +====================
>  
>  Numbering scheme for channels 0..4 is defined in EP9301 and EP9302 datasheets.
>  EP9307, EP9312 and EP9312 have 3 channels more (total 8), but the numbering is
> @@ -17,13 +21,20 @@ Assuming ep93xx_adc is IIO device0, you'd find the following entries under
>  
>    +-----------------+---------------+
>    | sysfs entry     | ball/pin name |
> -  +-----------------+---------------+
> +  +=================+===============+
>    | in_voltage0_raw | YM            |
> +  +-----------------+---------------+
>    | in_voltage1_raw | SXP           |
> +  +-----------------+---------------+
>    | in_voltage2_raw | SXM           |
> +  +-----------------+---------------+
>    | in_voltage3_raw | SYP           |
> +  +-----------------+---------------+
>    | in_voltage4_raw | SYM           |
> +  +-----------------+---------------+
>    | in_voltage5_raw | XP            |
> +  +-----------------+---------------+
>    | in_voltage6_raw | XM            |
> +  +-----------------+---------------+
>    | in_voltage7_raw | YP            |
>    +-----------------+---------------+
> diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.rst
> similarity index 73%
> rename from Documentation/iio/iio_configfs.txt
> rename to Documentation/iio/iio_configfs.rst
> index 4e5f101837a8..ecbfdb3afef7 100644
> --- a/Documentation/iio/iio_configfs.txt
> +++ b/Documentation/iio/iio_configfs.rst
> @@ -1,6 +1,9 @@
> +===============================
>  Industrial IIO configfs support
> +===============================
>  
>  1. Overview
> +===========
>  
>  Configfs is a filesystem-based manager of kernel objects. IIO uses some
>  objects that could be easily configured using configfs (e.g.: devices,
> @@ -10,20 +13,22 @@ See Documentation/filesystems/configfs/configfs.txt for more information
>  about how configfs works.
>  
>  2. Usage
> +========
>  
>  In order to use configfs support in IIO we need to select it at compile
>  time via CONFIG_IIO_CONFIGFS config option.
>  
> -Then, mount the configfs filesystem (usually under /config directory):
> +Then, mount the configfs filesystem (usually under /config directory)::
>  
> -$ mkdir /config
> -$ mount -t configfs none /config
> +  $ mkdir /config
> +  $ mount -t configfs none /config
>  
>  At this point, all default IIO groups will be created and can be accessed
>  under /config/iio. Next chapters will describe available IIO configuration
>  objects.
>  
>  3. Software triggers
> +====================
>  
>  One of the IIO default configfs groups is the "triggers" group. It is
>  automagically accessible when the configfs is mounted and can be found
> @@ -31,40 +36,40 @@ under /config/iio/triggers.
>  
>  IIO software triggers implementation offers support for creating multiple
>  trigger types. A new trigger type is usually implemented as a separate
> -kernel module following the interface in include/linux/iio/sw_trigger.h:
> +kernel module following the interface in include/linux/iio/sw_trigger.h::
>  
> -/*
> - * drivers/iio/trigger/iio-trig-sample.c
> - * sample kernel module implementing a new trigger type
> - */
> -#include <linux/iio/sw_trigger.h>
> +  /*
> +   * drivers/iio/trigger/iio-trig-sample.c
> +   * sample kernel module implementing a new trigger type
> +   */
> +  #include <linux/iio/sw_trigger.h>
>  
>  
> -static struct iio_sw_trigger *iio_trig_sample_probe(const char *name)
> -{
> +  static struct iio_sw_trigger *iio_trig_sample_probe(const char *name)
> +  {
>  	/*
>  	 * This allocates and registers an IIO trigger plus other
>  	 * trigger type specific initialization.
>  	 */
> -}
> +  }
>  
> -static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
> -{
> +  static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
> +  {
>  	/*
>  	 * This undoes the actions in iio_trig_sample_probe
>  	 */
> -}
> +  }
>  
> -static const struct iio_sw_trigger_ops iio_trig_sample_ops = {
> +  static const struct iio_sw_trigger_ops iio_trig_sample_ops = {
>  	.probe		= iio_trig_sample_probe,
>  	.remove		= iio_trig_sample_remove,
> -};
> +  };
>  
> -static struct iio_sw_trigger_type iio_trig_sample = {
> +  static struct iio_sw_trigger_type iio_trig_sample = {
>  	.name = "trig-sample",
>  	.owner = THIS_MODULE,
>  	.ops = &iio_trig_sample_ops,
> -};
> +  };
>  
>  module_iio_sw_trigger_driver(iio_trig_sample);
>  
> @@ -73,21 +78,24 @@ iio-trig-sample module will create 'trig-sample' trigger type directory
>  /config/iio/triggers/trig-sample.
>  
>  We support the following interrupt sources (trigger types):
> +
>  	* hrtimer, uses high resolution timers as interrupt source
>  
>  3.1 Hrtimer triggers creation and destruction
> +---------------------------------------------
>  
>  Loading iio-trig-hrtimer module will register hrtimer trigger types allowing
>  users to create hrtimer triggers under /config/iio/triggers/hrtimer.
>  
> -e.g:
> +e.g::
>  
> -$ mkdir /config/iio/triggers/hrtimer/instance1
> -$ rmdir /config/iio/triggers/hrtimer/instance1
> +  $ mkdir /config/iio/triggers/hrtimer/instance1
> +  $ rmdir /config/iio/triggers/hrtimer/instance1
>  
>  Each trigger can have one or more attributes specific to the trigger type.
>  
>  3.2 "hrtimer" trigger types attributes
> +--------------------------------------
>  
>  "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
>  It does introduce the sampling_frequency attribute to trigger directory.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> new file mode 100644
> index 000000000000..0593dca89a94
> --- /dev/null
> +++ b/Documentation/iio/index.rst
> @@ -0,0 +1,12 @@
> +:orphan:
> +
> +==============
> +Industrial I/O
> +==============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   iio_configfs
> +
> +   ep93xx_adc
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 1d736a4952ab..5bd51853b15e 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -28,7 +28,7 @@ config IIO_CONFIGFS
>  	help
>  	  This allows configuring various IIO bits through configfs
>  	  (e.g. software triggers). For more info see
> -	  Documentation/iio/iio_configfs.txt.
> +	  Documentation/iio/iio_configfs.rst.
>  
>  config IIO_TRIGGER
>  	bool "Enable triggered sampling support"

