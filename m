Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB12831EB91
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhBRP1y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhBRNgz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:36:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AEE64E5F;
        Thu, 18 Feb 2021 13:36:06 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:36:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 1/5] iio: Documentation: update definitions for
 bufferY and scan_elements
Message-ID: <20210218133603.2ca79632@archlinux>
In-Reply-To: <20210218121948.000017cd@Huawei.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
        <20210217083438.37865-2-alexandru.ardelean@analog.com>
        <20210218121948.000017cd@Huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Feb 2021 12:19:48 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 17 Feb 2021 10:34:34 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > Since the new change to the IIO buffer infrastructure, the buffer/ and
> > scan_elements/ directories have been merged into bufferY/ to have some
> > attributes available per-buffer.
> > 
> > This change updates the ABI docs to reflect this change.
> > 
> > The hwfifo attributes are not updated, as for now these should be used
> > via the legacy buffer/ directory until they are moved into core.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> 
> This doesn't really have anything to do with the rest of the set - so ideally
> you'd have sent it separately.
> 
> One trivial typo below, that I can fix whilst applying.
Applied with that fix.

Jonathan

> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 85 +++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d957f5da5c04..f2a72d7fbacb 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1118,12 +1118,16 @@ Description:
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
> >  KernelVersion:	2.6.35
> > +What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Number of scans contained by the buffer.
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
> >  KernelVersion:	2.6.35
> > +What:		/sys/bus/iio/devices/iio:deviceX/bufferY/enable
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Actually start the buffer capture up.  Will start trigger
> > @@ -1131,11 +1135,16 @@ Description:
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
> >  KernelVersion:	2.6.37
> > +What:		/sys/bus/iio/devices/iio:deviceX/buffeY  
> bufferY
> 
> I'll fix whilst applying.
> 
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Directory containing interfaces for elements that will be
> >  		captured for a single triggered sample set in the buffer.
> >  
> > +		Since kernel 5.11 the scan_elements attributes are merged into
> > +		the bufferY directory, to be configurable per buffer.
> > +
> >  What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_en
> >  What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_en
> >  What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_en
> > @@ -1164,6 +1173,34 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
> >  What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
> >  What:		/sys/.../iio:deviceX/scan_elements/in_proximity_en
> >  KernelVersion:	2.6.37
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_x_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_y_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_z_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_x_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_y_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_z_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_tilt_comp_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_tilt_comp_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_timestamp_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY-voltageZ_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_incli_x_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_incli_y_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressure_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_en
> > +What:		/sys/.../iio:deviceX/bufferY/in_proximity_en
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Scan element control for triggered data capture.
> > @@ -1185,6 +1222,23 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
> >  What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
> >  What:		/sys/.../iio:deviceX/scan_elements/in_proximity_type
> >  KernelVersion:	2.6.37
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_incli_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_timestamp_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_type
> > +What:		/sys/.../iio:deviceX/bufferY/in_proximity_type
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Description of the scan element data storage within the buffer
> > @@ -1241,6 +1295,33 @@ What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
> >  What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
> >  What:		/sys/.../iio:deviceX/scan_elements/in_proximity_index
> >  KernelVersion:	2.6.37
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_x_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_y_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_x_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_y_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_magn_z_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_magnetic_tilt_comp_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_from_north_true_tilt_comp_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_incli_x_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_incli_y_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_timestamp_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressureY_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_pressure_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_index
> > +What:		/sys/.../iio:deviceX/bufferY/in_proximity_index
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		A single positive integer specifying the position of this
> > @@ -1455,6 +1536,8 @@ Description:
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
> >  KernelVersion:	4.2
> > +What:		/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		A single positive integer specifying the maximum number of scan
> > @@ -1473,6 +1556,8 @@ Description:
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
> >  KernelVersion: 4.16
> > +What:		/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
> > +KernelVersion:	5.11
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		A read-only value indicating the bytes of data available in the  
> 

