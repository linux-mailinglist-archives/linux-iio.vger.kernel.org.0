Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9B4577F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfFNIaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 04:30:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40035 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFNIaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 04:30:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so1368425oie.7;
        Fri, 14 Jun 2019 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBX5S6bgTctWckd9/P2tFIY6izVzBb7AzQ5sf+y29+s=;
        b=Gyg1d0FpxDBC+CCyh543R9BGLPfy80rPIoRf/MsgcaS0uM1Im9H13jB4HsKCVDtBoB
         St4bp4/+bsODBPB57uTmdZduDlYV5DVtAWzhhaAtQQ4dgaWeYorGO66Xiu9nxvfdF+cs
         ojoUl7iQIcnVYpg2NN8Odte7eyBBM9/ip2j7Slt1k61d5k0FeshfQ1Sjx9s3Y3vUhZKF
         kIkq9wS2Nj1d/JJ/pEMH2c4FGyeMiWgy33Do3osNZmrUpZ8Ridruk0oPYmd7oxzIRT5z
         R2q68IDyV9aA9c30RtFl+mQpsStnAZVZ/rMZrjOQnyBdvcxnZKydJDkbzT6O1g4TbJVx
         oY5w==
X-Gm-Message-State: APjAAAUBEIsVToDoHGzZrr4AAprP+ra4iJYtNu3H1ZuJlya5U36abkOw
        r1j1yYBIx2d1TTWn5dqpqvVffI4ErnT4/CvsVYk=
X-Google-Smtp-Source: APXvYqx1omA4R75tw8TDas2oab9KcZIvx/qWC/wiBq28VqDt/zUvgcBSEWWYNiN8xHrBQ36Y0tGYodw0/oHg4FHPCEo=
X-Received: by 2002:aca:3256:: with SMTP id y83mr1140955oiy.110.1560501020169;
 Fri, 14 Jun 2019 01:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <b908fc6555df8cae3e4c734b2d5f6284c46a5f14.1560477540.git.mchehab+samsung@kernel.org>
In-Reply-To: <b908fc6555df8cae3e4c734b2d5f6284c46a5f14.1560477540.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 10:30:07 +0200
Message-ID: <CAJZ5v0gYFCXfdPuuPMVU4ccyhPSdPJvEVJM309aQwAeTjSWeVQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] ABI: fix some syntax issues at the ABI database
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-iio@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 14, 2019 at 4:04 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>
> On those three files, the ABI representation described at
> README are violated.
>
> - at sysfs-bus-iio-proximity-as3935:
>         a ':' character is missing after "What"
>
> - at sysfs-class-devfreq:
>         there's a typo at Description
>
> - at sysfs-class-cxl, it is using the ":" character at a
>         file preamble, causing it to be misinterpreted as a
>         tag.
>
> - On the other files, instead of "What", they use "Where".
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/ABI/testing/pstore              |  2 +-
>  .../sysfs-bus-event_source-devices-format     |  2 +-
>  .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |  6 ++---
>  .../ABI/testing/sysfs-bus-iio-distance-srf08  |  4 ++--
>  .../testing/sysfs-bus-iio-proximity-as3935    |  4 ++--
>  .../ABI/testing/sysfs-bus-pci-devices-cciss   | 22 +++++++++----------
>  .../testing/sysfs-bus-usb-devices-usbsevseg   | 12 +++++-----
>  Documentation/ABI/testing/sysfs-class-cxl     |  6 ++---
>  Documentation/ABI/testing/sysfs-class-devfreq |  2 +-
>  .../ABI/testing/sysfs-class-powercap          |  2 +-
>  Documentation/ABI/testing/sysfs-kernel-fscaps |  2 +-
>  .../ABI/testing/sysfs-kernel-vmcoreinfo       |  2 +-
>  12 files changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
> index 5fca9f5e10a3..8d6e48f4e8ef 100644
> --- a/Documentation/ABI/testing/pstore
> +++ b/Documentation/ABI/testing/pstore
> @@ -1,4 +1,4 @@
> -Where:         /sys/fs/pstore/... (or /dev/pstore/...)
> +What:          /sys/fs/pstore/... (or /dev/pstore/...)
>  Date:          March 2011
>  Kernel Version: 2.6.39
>  Contact:       tony.luck@intel.com
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> index 77f47ff5ee02..b6f8748e0200 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> @@ -1,4 +1,4 @@
> -Where:         /sys/bus/event_source/devices/<dev>/format
> +What:          /sys/bus/event_source/devices/<dev>/format
>  Date:          January 2012
>  Kernel Version: 3.3
>  Contact:       Jiri Olsa <jolsa@redhat.com>
> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> index feb2e4a87075..29bd447e50a0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> @@ -1,18 +1,18 @@
> -Where:         /sys/bus/i2c/devices/.../heading0_input
> +What:          /sys/bus/i2c/devices/.../heading0_input
>  Date:          April 2010
>  Kernel Version: 2.6.36?
>  Contact:       alan.cox@intel.com
>  Description:   Reports the current heading from the compass as a floating
>                 point value in degrees.
>
> -Where:         /sys/bus/i2c/devices/.../power_state
> +What:          /sys/bus/i2c/devices/.../power_state
>  Date:          April 2010
>  Kernel Version: 2.6.36?
>  Contact:       alan.cox@intel.com
>  Description:   Sets the power state of the device. 0 sets the device into
>                 sleep mode, 1 wakes it up.
>
> -Where:         /sys/bus/i2c/devices/.../calibration
> +What:          /sys/bus/i2c/devices/.../calibration
>  Date:          April 2010
>  Kernel Version: 2.6.36?
>  Contact:       alan.cox@intel.com
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> index 0a1ca1487fa9..a133fd8d081a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> @@ -1,4 +1,4 @@
> -What           /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
> +What:          /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
>  Date:          January 2017
>  KernelVersion: 4.11
>  Contact:       linux-iio@vger.kernel.org
> @@ -6,7 +6,7 @@ Description:
>                 Show or set the gain boost of the amp, from 0-31 range.
>                 default 31
>
> -What           /sys/bus/iio/devices/iio:deviceX/sensor_max_range
> +What:          /sys/bus/iio/devices/iio:deviceX/sensor_max_range
>  Date:          January 2017
>  KernelVersion: 4.11
>  Contact:       linux-iio@vger.kernel.org
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> index 9a17ab5036a4..c59d95346341 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> @@ -1,4 +1,4 @@
> -What           /sys/bus/iio/devices/iio:deviceX/in_proximity_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_proximity_input
>  Date:          March 2014
>  KernelVersion: 3.15
>  Contact:       Matt Ranostay <matt.ranostay@konsulko.com>
> @@ -6,7 +6,7 @@ Description:
>                 Get the current distance in meters of storm (1km steps)
>                 1000-40000 = distance in meters
>
> -What           /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
> +What:          /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
>  Date:          March 2014
>  KernelVersion: 3.15
>  Contact:       Matt Ranostay <matt.ranostay@konsulko.com>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> index 53d99edd1d75..eb449169c30b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> @@ -1,66 +1,66 @@
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/model
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/model
>  Date:          March 2009
>  Kernel Version: 2.6.30
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the SCSI INQUIRY page 0 model for logical drive
>                 Y of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
>  Date:          March 2009
>  Kernel Version: 2.6.30
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the SCSI INQUIRY page 0 revision for logical
>                 drive Y of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
>  Date:          March 2009
>  Kernel Version: 2.6.30
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the SCSI INQUIRY page 83 serial number for logical
>                 drive Y of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
>  Date:          March 2009
>  Kernel Version: 2.6.30
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the SCSI INQUIRY page 0 vendor for logical drive
>                 Y of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
>  Date:          March 2009
>  Kernel Version: 2.6.30
>  Contact:       iss_storagedev@hp.com
>  Description:   A symbolic link to /sys/block/cciss!cXdY
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/rescan
> +What:          /sys/bus/pci/devices/<dev>/ccissX/rescan
>  Date:          August 2009
>  Kernel Version:        2.6.31
>  Contact:       iss_storagedev@hp.com
>  Description:   Kicks of a rescan of the controller to discover logical
>                 drive topology changes.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
>  Date:          August 2009
>  Kernel Version: 2.6.31
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the 8-byte LUN ID used to address logical
>                 drive Y of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
>  Date:          August 2009
>  Kernel Version: 2.6.31
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the RAID level of logical drive Y of
>                 controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
> +What:          /sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
>  Date:          August 2009
>  Kernel Version: 2.6.31
>  Contact:       iss_storagedev@hp.com
>  Description:   Displays the usage count (number of opens) of logical drive Y
>                 of controller X.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/resettable
> +What:          /sys/bus/pci/devices/<dev>/ccissX/resettable
>  Date:          February 2011
>  Kernel Version:        2.6.38
>  Contact:       iss_storagedev@hp.com
> @@ -71,7 +71,7 @@ Description:  Value of 1 indicates the controller can honor the reset_devices
>                 a dump device, as kdump requires resetting the device in order
>                 to work reliably.
>
> -Where:         /sys/bus/pci/devices/<dev>/ccissX/transport_mode
> +What:          /sys/bus/pci/devices/<dev>/ccissX/transport_mode
>  Date:          July 2011
>  Kernel Version:        3.0
>  Contact:       iss_storagedev@hp.com
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> index 70d00dfa443d..f6199b314196 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> +++ b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> @@ -1,12 +1,12 @@
> -Where:         /sys/bus/usb/.../powered
> +What:          /sys/bus/usb/.../powered
>  Date:          August 2008
>  Kernel Version:        2.6.26
>  Contact:       Harrison Metzger <harrisonmetz@gmail.com>
>  Description:   Controls whether the device's display will powered.
>                 A value of 0 is off and a non-zero value is on.
>
> -Where:         /sys/bus/usb/.../mode_msb
> -Where:         /sys/bus/usb/.../mode_lsb
> +What:          /sys/bus/usb/.../mode_msb
> +What:          /sys/bus/usb/.../mode_lsb
>  Date:          August 2008
>  Kernel Version:        2.6.26
>  Contact:       Harrison Metzger <harrisonmetz@gmail.com>
> @@ -16,7 +16,7 @@ Description:  Controls the devices display mode.
>                 for an 8 character display the values are
>                         MSB 0x08; LSB 0xFF.
>
> -Where:         /sys/bus/usb/.../textmode
> +What:          /sys/bus/usb/.../textmode
>  Date:          August 2008
>  Kernel Version:        2.6.26
>  Contact:       Harrison Metzger <harrisonmetz@gmail.com>
> @@ -25,13 +25,13 @@ Description:        Controls the way the device interprets its text buffer.
>                 hex:    each character is between 0-15
>                 ascii:  each character is between '0'-'9' and 'A'-'F'.
>
> -Where:         /sys/bus/usb/.../text
> +What:          /sys/bus/usb/.../text
>  Date:          August 2008
>  Kernel Version:        2.6.26
>  Contact:       Harrison Metzger <harrisonmetz@gmail.com>
>  Description:   The text (or data) for the device to display
>
> -Where:         /sys/bus/usb/.../decimals
> +What:          /sys/bus/usb/.../decimals
>  Date:          August 2008
>  Kernel Version:        2.6.26
>  Contact:       Harrison Metzger <harrisonmetz@gmail.com>
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index bbbabffc682a..fc7c6f7c21b3 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -1,6 +1,6 @@
> -Note: Attributes that are shared between devices are stored in the directory
> -pointed to by the symlink device/.
> -Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
> +Please notice that attributes that are shared between devices are stored in
> +the directory pointed to by the symlink device/.
> +For example, the real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
>  /sys/class/cxl/afu0.0s/device/irqs_max, i.e. /sys/class/cxl/afu0.0/irqs_max.
>
>
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index ee39acacf6f8..01196e19afca 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -47,7 +47,7 @@ Description:
>  What:          /sys/class/devfreq/.../trans_stat
>  Date:          October 2012
>  Contact:       MyungJoo Ham <myungjoo.ham@samsung.com>
> -Descrtiption:
> +Description:
>                 This ABI shows the statistics of devfreq behavior on a
>                 specific device. It shows the time spent in each state and
>                 the number of transitions between states.
> diff --git a/Documentation/ABI/testing/sysfs-class-powercap b/Documentation/ABI/testing/sysfs-class-powercap
> index db3b3ff70d84..f333a0ccc29b 100644
> --- a/Documentation/ABI/testing/sysfs-class-powercap
> +++ b/Documentation/ABI/testing/sysfs-class-powercap
> @@ -147,6 +147,6 @@ What:               /sys/class/powercap/.../<power zone>/enabled
>  Date:          September 2013
>  KernelVersion: 3.13
>  Contact:       linux-pm@vger.kernel.org
> -Description
> +Description:
>                 This allows to enable/disable power capping at power zone level.
>                 This applies to current power zone and its children.
> diff --git a/Documentation/ABI/testing/sysfs-kernel-fscaps b/Documentation/ABI/testing/sysfs-kernel-fscaps
> index 50a3033b5e15..bcff34665192 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-fscaps
> +++ b/Documentation/ABI/testing/sysfs-kernel-fscaps
> @@ -2,7 +2,7 @@ What:           /sys/kernel/fscaps
>  Date:          February 2011
>  KernelVersion: 2.6.38
>  Contact:       Ludwig Nussel <ludwig.nussel@suse.de>
> -Description
> +Description:
>                 Shows whether file system capabilities are honored
>                 when executing a binary
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo b/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
> index 7bd81168e063..1f1087a5f075 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
> +++ b/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
> @@ -4,7 +4,7 @@ KernelVersion:  2.6.24
>  Contact:       Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
>                 Kexec Mailing List <kexec@lists.infradead.org>
>                 Vivek Goyal <vgoyal@redhat.com>
> -Description
> +Description:
>                 Shows physical address and size of vmcoreinfo ELF note.
>                 First value contains physical address of note in hex and
>                 second value contains the size of note in hex. This ELF
> --
> 2.21.0
>
