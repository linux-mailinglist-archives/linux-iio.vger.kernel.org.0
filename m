Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5031C993
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPLVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 16 Feb 2021 06:21:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2568 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPLVf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 06:21:35 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dfz2R1ZTyz67pQ0;
        Tue, 16 Feb 2021 19:17:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Feb 2021 12:20:52 +0100
Received: from localhost (10.47.75.223) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Feb
 2021 11:20:51 +0000
Date:   Tue, 16 Feb 2021 11:19:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Subject: Re: [PATCH v6 00/24] iio: core,buffer: add support for multiple IIO
 buffers per IIO device
Message-ID: <20210216111946.00001ea3@Huawei.com>
In-Reply-To: <CA+U=DsryDk+91F3bfL-vXhqwEqw7yF-po2A4BXwkzKYy2352WQ@mail.gmail.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215135712.79aae785@archlinux>
        <CA+U=DsryDk+91F3bfL-vXhqwEqw7yF-po2A4BXwkzKYy2352WQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.75.223]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 16:10:45 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Feb 15, 2021 at 3:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 15 Feb 2021 12:40:19 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > Hi Alex,
> >
> > One thought on this that came up whilst reading through it again.
> > There are several uses for multiple buffers.
> > 1) input vs output buffers
> > 2) A device with separately clocked sampling of different channels.  
> 
> So, ADI typically has use-cases for 1).
> Mostly RF transceivers.
> Traditionally, these were written (inside the ADI tree) as 2-3 IIO
> devices (1 IIO device for each path,1 for TX and 1-2 for RX).
> With multi-buffer, they can be a single IIO device with 2-3 IIO buffers.
> 
> There are some ADI devices that have channels that can run at different speeds.
> But this hasn't been an important use-cases to deal with.
> Typically, a common-rate would be picked [for all channels] and that's that.
> I think some people find this per-channel rates interesting; but let's see.

The nasty ones for multiple speeds tend to be sensor hubs and similar
units where there is heavy processing going on.

Often they are taking in a bunch of physical sensors and
1) Shoving the data straight out unprocessed whenever it shows up.
   The raw sensors aren't running in sync, so they drift across each other and
   other fun things like that.
2) Doing sensor fusion in batches and kicking out an quaternion every now
   and then.

They work on the basis of tagging the samples in a fifo with what they actually
are.   Often there is very little control of the flow so we've previously ended
up with the same multi IIO device solution, with a common core redirecting the 
flows to the right devices (basically acting as an MFD).

Thankfully those cases don't play well with triggers anyway so we mostly
don't expose them.

From memory, cros_ec and st_lsm6dsx are like this.  I think there are a few more.


> 
> >
> > For case 2, there is at least sometimes a trigger involved
> > (often data ready) so we probably also need to think long term about how
> > to support multiple current_triggers in one driver.
> >
> > I guess that's something for us to figure out when we need it however.
> >
> > Thanks for you hard work on finally getting this upstream.
> > + Lars (and maybe others) for earlier work on this.  
> 
> Thank you as well.
> 
> >
> > Whilst I've applied all these, they are only exposed in the testing branch
> > of iio.git on kernel.org so far and as such any additional review anyone
> > else wants to give would be welcome!  
> 
> I feel there may be other users stumbling over this multibuffer
> support, and try it out.
> Often people don't seem to care about multibuffer, until they really need it.
> A bit of chicken-n-egg problem.
> But after being added, people may see it and start to use it.

Agreed.  I'm fairly confident that the ABI is fine, so I'm not particularly
worried if we need to make further adjustments as other users show up.

Jonathan

> 
> >
> > Jonathan
> >  
> > > Changelog v5 -> v6:
> > > * https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t
> > > * merged series 'iio: kfifo: define a devm_iio_kfifo_buffer_setup helper' into this
> > >    https://lore.kernel.org/linux-iio/20210214143313.67202-4-alexandru.ardelean@analog.com/T/#u
> > > * merged patch 'iio: buffer-dma,adi-axi-adc: introduce devm_iio_dmaengine_buffer_setup()' into this
> > >    https://lore.kernel.org/linux-iio/20210214155817.68678-1-alexandru.ardelean@analog.com/T/#u
> > > * patch 'iio: core: wrap iio device & buffer into struct for character devices'
> > >    - moved kfree(ib) to be first in iio_chrdev_release() to make the cleanup
> > >      order be reversed as the open() order
> > > * patch 'iio: buffer: group attr count and attr alloc'
> > >    - sizeof(struct attribute *)  ->   sizeof(*attr)  in kcalloc()
> > > * patch 'iio: core: merge buffer/ & scan_elements/ attributes'
> > >    - minor rework in iio_buffer_register_legacy_sysfs_groups() to
> > >      use more 'sizeof(*attrs)' in allocations
> > >    - fixed typo 'legacy_buffer_el_group' -> 'legacy_buffer_group'
> > >    - updated comment about
> > >      '/* we only need to link the legacy buffer groups for the first buffer */'
> > >      to
> > >      '/* we only need to register the legacy groups for the first buffer */'
> > > * patch 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
> > >    - removed 'buf_name' from iio_device_buffer_getfd();
> > >       passing "iio:buffer" name; since it should be a class-name
> > >    - removed extra-line in drivers/iio/industrial-core.c
> > >    -  changed init order in iio_device_buffer_getfd() and matched it with reverse in
> > >       iio_buffer_chrdev_release()
> > >    - calling put_unused_fd() in iio_device_buffer_getfd() if copy_to_user() fails
> > > * added 'iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls'
> > > * patch ' iio: buffer: introduce support for attaching more IIO buffers'
> > >    - now handling iio_device_attach_buffer() error returns
> > >    - rename iio_buffer_free_sysfs_and_mask() -> iio_buffers_free_sysfs_and_mask()
> > >    - rename iio_buffer_alloc_sysfs_and_mask() -> iio_buffer_alloc_sysfs_and_mask()
> > > * patch 'tools: iio: convert iio_generic_buffer to use new IIO buffer API'
> > >   - removed extra close() if getfd() ioctl() errors out
> > >   - added comment that the sanity check for buffer0 should not be done
> > >     under normal operation
> > >   - update message from
> > >    "This device does not support buffers"
> > >    to
> > >    "Device does not have this many buffers"
> > >
> > > Changelog v4 -> v5:
> > > * https://lore.kernel.org/linux-iio/20210210100823.46780-1-alexandru.ardelean@analog.com/T/#t
> > > * patch 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
> > >   don't return -EBUSY in iio_buffer_poll_wrapper(); return 0
> > >   __poll_t is unsigned, so returning 0 is the best we can do
> > >   Reported-by: kernel test robot <lkp@intel.com>
> > > * patch 'iio: buffer: dmaengine: obtain buffer object from attribute'
> > >   removed unused 'indio_dev' variable; seems i missed this initially
> > > * patch 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
> > >   call 'wake_up(buffer->pollq)' in iio_buffer_chrdev_release()
> > >
> > > Changelog v3 -> v4:
> > > * https://lore.kernel.org/linux-iio/20210201145105.20459-1-alexandru.ardelean@analog.com/
> > > * patch 'docs: ioctl-number.rst: reserve IIO subsystem ioctl() space'
> > >    remove 'uapi/' from `uapi/linux/iio/*.h`
> > > * patch 'iio: core: register chardev only if needed'
> > >    add commit comment about potentially breaking userspace ABI with chardev removal
> > > * patch 'iio: core: rework iio device group creation'
> > >    remove NULL re-init in iio_device_unregister_sysfs() ; memory is being free'd
> > > * patch 'iio: buffer: group attr count and attr alloc'
> > >   extend commit comment about the 2 or 1 buffer directores
> > > * patch 'iio: core: merge buffer/ & scan_elements/ attributes'
> > >    fixed static checker complaints
> > >     - removed unused global
> > >     - initialize omitted 'ret = -ENOMEM' on error path
> > >     - made iio_buffer_unregister_legacy_sysfs_groups() static
> > > * patch 'iio: buffer: wrap all buffer attributes into iio_dev_attr'
> > >    - update some omitted unwindings; seems i forgot a few originally
> > >      this was showing up when trying to read from buffer1
> > > * add patch 'iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc func'
> > > * patch 'iio: buffer: introduce support for attaching more IIO buffers'
> > >    - removed 'iio_dev_opaque->attached_buffers = NULL' after kfree()
> > >    - using 'iio_dev_opaque->attached_buffers_cnt' to check that we have buffers
> > >       instead of checking 'indio_dev->buffer'
> > > * patch 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
> > >    - replaced -ENOENT with -ENODEV when buffer index is out of range
> > > * add 'iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()'
> > > * add 'iio: buffer: dmaengine: obtain buffer object from attribute'
> > > * add tools/iio patches for new multibuffer logic
> > >    tools: iio: make iioutils_get_type() private in iio_utils
> > >    tools: iio: privatize globals and functions in iio_generic_buffer.c file
> > >    tools: iio: convert iio_generic_buffer to use new IIO buffer API
> > >
> > > Changelog v2 -> v3:
> > > * https://lore.kernel.org/linux-iio/20210122155805.83012-1-alexandru.ardelean@analog.com/
> > > * added commit 'docs: ioctl-number.rst: reserve IIO subsystem ioctl() space'
> > >   reserving 'i' 0x90-0x9F ioctls for IIO
> > >   I did not see any conflicts with others (in the doc)
> > >   - related to this, the new IIO_BUFFER_GET_FD_IOCTL is now at 'i' 0x91
> > > * changed approach for creating sysfs buffer directories;
> > >   - they are now created as groups on the IIO device; that also means
> > >     that the groups array needs to be krealloc-ed and assign later in
> > >     the registration
> > >   - merged bufferX/ and scan_elementsX/ directories into a single
> > >     bufferX/ directory
> > >   - for legacy the buffer/ & scan_elements/ directories are kept; but
> > >     they're groups objects have been moved on the iio_dev_opaque object
> > >   - internally, the iio_dev_attr type is being extended to hold a
> > >     reference for an IIO buffer;
> > >     = this is great for scan_elements attributes
> > >     = and for the rest of the iio_buffer attributes, it means we need to
> > >       wrap them into iio_dev_attr
> > >
> > > Changelog v1 -> v2:
> > > * https://lore.kernel.org/linux-iio/20201117162340.43924-1-alexandru.ardelean@analog.com/
> > > * 'iio: buffer: rework buffer & scan_elements dir creation'
> > >   add more doc-strings detailing the reasoning for this change
> > > * 'iio: buffer: re-route scan_elements via it's kobj_type'
> > >   move list_del() before the kfree()'s in the list destruction
> > > * 'iio: buffer: introduce support for attaching more IIO buffers'
> > >   - changed to 'cnt' variable vs re-using the 'i' for unwinding in
> > >     iio_buffer_alloc_sysfs_and_mask()
> > >   - removed kfree(old) in iio_device_attach_buffer()
> > >   - made iio_device_attach_buffer() an int return; this means that some
> > >     follow up patches are needed to make this return value be used;
> > > * 'iio: buffer: add ioctl() to support opening extra buffers for IIO device'
> > >   - tested ioctl() with a simple C program; attached to comment;
> > >   - changed 'i' variable usage to 'sz' for alloc
> > >   - changed logic for buffer0; returning FD 0; userspace should know
> > >     that the IIO_BUFFER_GET_FD_IOCTL call returns 0 for buffer0;
> > >     this is because I can't find a way to determine the FD of the
> > >     ioctl() in the kernel; duplicating an ioctl() for buffer0 is also bad;
> > >
> > >
> > > Alexandru Ardelean (24):
> > >   iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()
> > >   iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
> > >   iio: make use of devm_iio_kfifo_buffer_setup() helper
> > >   iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
> > >   iio: kfifo: un-export devm_iio_kfifo_allocate() function
> > >   iio: buffer-dma,adi-axi-adc: introduce
> > >     devm_iio_dmaengine_buffer_setup()
> > >   docs: ioctl-number.rst: reserve IIO subsystem ioctl() space
> > >   iio: core: register chardev only if needed
> > >   iio: core-trigger: make iio_device_register_trigger_consumer() an int
> > >     return
> > >   iio: core: rework iio device group creation
> > >   iio: buffer: group attr count and attr alloc
> > >   iio: core: merge buffer/ & scan_elements/ attributes
> > >   iio: add reference to iio buffer on iio_dev_attr
> > >   iio: buffer: wrap all buffer attributes into iio_dev_attr
> > >   iio: buffer: dmaengine: obtain buffer object from attribute
> > >   iio: core: wrap iio device & buffer into struct for character devices
> > >   iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc
> > >   iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls
> > >   iio: buffer: introduce support for attaching more IIO buffers
> > >   iio: buffer: add ioctl() to support opening extra buffers for IIO
> > >     device
> > >   iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()
> > >   tools: iio: make iioutils_get_type() private in iio_utils
> > >   tools: iio: privatize globals and functions in iio_generic_buffer.c
> > >     file
> > >   tools: iio: convert iio_generic_buffer to use new IIO buffer API
> > >
> > >  .../driver-api/driver-model/devres.rst        |   3 +-
> > >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> > >  drivers/iio/accel/sca3000.c                   |  19 +-
> > >  drivers/iio/accel/ssp_accel_sensor.c          |  14 +-
> > >  drivers/iio/adc/adi-axi-adc.c                 |  12 +-
> > >  drivers/iio/adc/ina2xx-adc.c                  |  14 +-
> > >  drivers/iio/adc/ti_am335x_adc.c               |  24 +-
> > >  .../buffer/industrialio-buffer-dmaengine.c    |  35 +-
> > >  .../buffer/industrialio-triggered-buffer.c    |  10 +-
> > >  drivers/iio/buffer/kfifo_buf.c                |  40 +-
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    |  13 +-
> > >  drivers/iio/dummy/iio_simple_dummy_buffer.c   |  68 +--
> > >  drivers/iio/gyro/ssp_gyro_sensor.c            |  14 +-
> > >  drivers/iio/health/max30100.c                 |  16 +-
> > >  drivers/iio/health/max30102.c                 |  16 +-
> > >  drivers/iio/iio_core.h                        |  32 +-
> > >  drivers/iio/iio_core_trigger.h                |   4 +-
> > >  .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  14 +-
> > >  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  13 +-
> > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  15 +-
> > >  drivers/iio/industrialio-buffer.c             | 494 ++++++++++++++----
> > >  drivers/iio/industrialio-core.c               | 113 +++-
> > >  drivers/iio/industrialio-event.c              |   6 +-
> > >  drivers/iio/industrialio-trigger.c            |   6 +-
> > >  drivers/iio/light/acpi-als.c                  |  12 +-
> > >  drivers/iio/light/apds9960.c                  |  16 +-
> > >  .../staging/iio/impedance-analyzer/ad5933.c   |  23 +-
> > >  include/linux/iio/buffer-dmaengine.h          |   7 +-
> > >  include/linux/iio/buffer.h                    |   4 +-
> > >  include/linux/iio/buffer_impl.h               |  21 +-
> > >  include/linux/iio/iio-opaque.h                |  14 +
> > >  include/linux/iio/iio.h                       |   5 -
> > >  include/linux/iio/kfifo_buf.h                 |   7 +-
> > >  include/linux/iio/sysfs.h                     |   3 +
> > >  include/uapi/linux/iio/buffer.h               |  10 +
> > >  tools/iio/Makefile                            |   1 +
> > >  tools/iio/iio_generic_buffer.c                | 153 ++++--
> > >  tools/iio/iio_utils.c                         |  18 +-
> > >  tools/iio/iio_utils.h                         |   8 +-
> > >  39 files changed, 856 insertions(+), 442 deletions(-)
> > >  create mode 100644 include/uapi/linux/iio/buffer.h
> > >  
> >  

