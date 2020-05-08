Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243A1CB109
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEHNyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44508 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbgEHNyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Die7l003260;
        Fri, 8 May 2020 09:54:01 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2j5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:01 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds0eA038773
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 09:53:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 09:53:53 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:53:53 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwk030263;
        Fri, 8 May 2020 09:53:52 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Date:   Fri, 8 May 2020 16:53:34 +0300
Message-ID: <20200508135348.15229-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I blew a few fuses trying to get to this combination.
And I still don't like this one, but it works.

Some patches here [like Lars' patches] are here just make things easier
to apply when moving from the ADI tree to the upstream one.
For a final patchset I'll need to re-apply/re-test.

A working version of this patchset but also with output buffer support
is here:
 https://github.com/analogdevicesinc/linux/tree/adi-iio-buffers-work
[ it's based on 4.19 ]

It will take a few more patches to bring output support to this tree,
but this should add initial support for multiple IIO buffers per device.
I haven't tested this patchset, I've tested the one in the link above.
I currently don't have [at hand] any devices that would benefit from
using multiple buffers per IIO device. Maybe when I get back to the
office.

Firstly: I need a bit of help in trying to symlink from the kernel
files in the /dev folder. I could not find any examples of how this is
done [without cracking open some deep kernel/kernfs code], so maybe it's
done via userspace?
Any suggestions are welcome.

I noticed that symlinking via sysfs_create_link() is fine outside of the
fs/ folder, so that's what I used.

I think I also partially understand why Lars was initially against doing
this 'multiple IIO buffers per IIO device'.
I've tried various combinations of doing things, and nothing fits
perfect, without feeling like I'm doing some sort of mini-frankenstein,
just in order to preserve some backwards compatibility.

So, to make this work, what I need to do now, is:
------------
root@analog:~# cd /dev/
root@analog:/dev# ln -s iio\:buffer3\:0 iio\:device3
root@analog:/dev# ln -s iio\:buffer4\:0 iio\:device4
root@analog:/dev# ls | grep iio
iio:buffer3:0
iio:buffer3:1
iio:buffer3:2
iio:buffer3:3
iio:buffer4:0
iio:device0
iio:device1
iio:device3
iio:device4
------------

device3 is an ADC with 4 buffers attached, only the first one is
currently being used (in legacy mode); the other 3 aren't being used.

The IIO buffer devices are named '/dev/iio:bufferX:Y', X being the
ID of the IIO device, and Y being the ID of the buffer of device X.
These could be renamed to '/dev/iio:deviceX:Y', but that would be
confusing I guess.

Then
------------
root@analog:/# ls /sys/bus/iio/devices/
iio:buffer3:0  iio:buffer3:1  iio:buffer3:2  iio:buffer3:3  iio:buffer4:0  iio:device0  iio:device1  iio:device2  iio:device3  iio:device4
------------
root@analog:/# ls /sys/bus/iio/devices/iio:buffer3:0
data_available  dev  enable  length  length_align_bytes  power  scan_elements  subsystem  uevent  watermark
------------
root@analog:/# ls -la /sys/bus/iio/devices/iio\:device3/
total 0
drwxr-xr-x 8 root root    0 May  8 13:00 .
drwxr-xr-x 4 root root    0 May  8 12:53 ..
lrwxrwxrwx 1 root root    0 May  8 13:00 buffer -> iio:buffer3:0
drwxrwxrwx 2 root root    0 May  8 12:53 events
drwxrwxrwx 4 root root    0 May  8 12:53 iio:buffer3:0
drwxrwxrwx 4 root root    0 May  8 12:53 iio:buffer3:1
drwxrwxrwx 4 root root    0 May  8 12:53 iio:buffer3:2
drwxrwxrwx 4 root root    0 May  8 12:53 iio:buffer3:3
-rw-rw-rw- 1 root root 4096 May  8 12:54 in_voltage0_test_mode
-rw-rw-rw- 1 root root 4096 May  8 12:54 in_voltage1_test_mode
-rw-rw-rw- 1 root root 4096 May  8 12:54 in_voltage_sampling_frequency
-rw-rw-rw- 1 root root 4096 May  8 12:53 in_voltage_scale
-rw-rw-rw- 1 root root 4096 May  8 12:53 in_voltage_scale_available
-rw-rw-rw- 1 root root 4096 May  8 12:53 in_voltage_test_mode_available
-rw-rw-rw- 1 root root 4096 May  8 12:53 name
lrwxrwxrwx 1 root root    0 May  8 13:00 of_node -> ../../../../../firmware/devicetree/base/fpga-axi@0/axi-ad9680-hpc@44a10000
drwxrwxrwx 2 root root    0 May  8 12:53 power
lrwxrwxrwx 1 root root    0 May  8 13:00 scan_elements -> iio:buffer3:0/scan_elements
lrwxrwxrwx 1 root root    0 May  8 13:00 subsystem -> ../../../../../bus/iio
-rw-rw-rw- 1 root root 4096 May  8 12:53 uevent
------------
root@analog:/# ls -la /sys/bus/iio/devices/iio:device3/iio:buffer3:0/
total 0
drwxrwxrwx 4 root root    0 May  8 12:53 .
drwxr-xr-x 8 root root    0 May  8 13:00 ..
-rw-rw-rw- 1 root root 4096 May  8 12:53 data_available
-rw-rw-rw- 1 root root 4096 May  8 12:53 dev
-rw-rw-rw- 1 root root 4096 May  8 12:53 enable
-rw-rw-rw- 1 root root 4096 May  8 12:53 length
-rw-rw-rw- 1 root root 4096 May  8 12:53 length_align_bytes
drwxrwxrwx 2 root root    0 May  8 12:53 power
drwxrwxrwx 2 root root    0 May  8 12:53 scan_elements
lrwxrwxrwx 1 root root    0 May  8 12:53 subsystem -> ../../../../../../bus/iio
-rw-rw-rw- 1 root root 4096 May  8 12:53 uevent
-rw-rw-rw- 1 root root 4096 May  8 12:53 watermark
------------

Using our fancy IIO-oscilloscope[1] app with this format, seems to work.
[1] https://github.com/analogdevicesinc/iio-oscilloscope

Linking the 'scan_elements' folder from the first buffer looks a
bit fishy [the code I mean]; it requires that the buffer device be added
first, so that the 'scan_elements' be attached via kobject, so that we
can have the kobject (as a symlink target).
Again, I did not want to crack open the kernfs.

What I don't like, is that iio:device3 has iio:buffer3:0 (to 3).
This is because the 'buffer->dev.parent = &indio_dev->dev'.
But I do feel this is correct.
So, now I don't know whether to leave it like that or symlink to shorter
versions like 'iio:buffer3:Y' -> 'iio:device3/bufferY'.
The reason for naming the IIO buffer devices to 'iio:bufferX:Y' is
mostly to make the names unique. It would have looked weird to do
'/dev/buffer1' if I would have named the buffer devices 'bufferX'.

So, now I'm thinking of whether all this is acceptable.
Or what is acceptable?
Should I symlink 'iio:device3/iio:buffer3:0' -> 'iio:device3/buffer0'?
What else should I consider moving forward?
What means forward?
Where did I leave my beer?

Well, if you've found my beer, it means you got this far :)
Thanks for reading all of this [including this bit of quarantine humor].

Alexandru Ardelean (12):
  iio: buffer: add back-ref from iio_buffer to iio_dev
  iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
  iio: core: register chardev only if needed
  iio: buffer,event: duplicate chardev creation for buffers & events
  iio: core: add simple centralized mechanism for ioctl() handlers
  iio: core: use new common ioctl() mechanism
  iio: buffer: split buffer sysfs creation to take buffer as primary arg
  iio: buffer: remove attrcount_orig var from sysfs creation
  iio: buffer: add underlying device object and convert buffers to
    devices
  iio: buffer: symlink the scan_elements dir back into IIO device's dir
  iio: unpack all iio buffer attributes correctly
  iio: buffer: convert single buffer to list of buffers

Lars-Peter Clausen (2):
  iio: Move scan mask management to the core
  iio: hw_consumer: use new scanmask functions

 drivers/iio/accel/adxl372.c                   |   6 +-
 drivers/iio/accel/bmc150-accel-core.c         |   6 +-
 drivers/iio/buffer/industrialio-buffer-cb.c   |  16 +-
 .../buffer/industrialio-buffer-dmaengine.c    |   4 +-
 drivers/iio/buffer/industrialio-hw-consumer.c |  19 +-
 drivers/iio/iio_core.h                        |  40 +-
 drivers/iio/industrialio-buffer.c             | 468 ++++++++++++++----
 drivers/iio/industrialio-core.c               | 174 +++----
 drivers/iio/industrialio-event.c              | 100 +++-
 drivers/iio/inkern.c                          |  15 +
 include/linux/iio/buffer.h                    |   3 +
 include/linux/iio/buffer_impl.h               |  24 +-
 include/linux/iio/consumer.h                  |  10 +
 include/linux/iio/iio.h                       |  12 +-
 14 files changed, 688 insertions(+), 209 deletions(-)

-- 
2.17.1

