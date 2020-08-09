Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2164823FD38
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgHIHo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 03:44:28 -0400
Received: from mailout05.rmx.de ([94.199.90.90]:53858 "EHLO mailout05.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHIHo1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 03:44:27 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout05.rmx.de (Postfix) with ESMTPS id 4BPWMB117cz9x91;
        Sun,  9 Aug 2020 09:44:22 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BPWLg2sk0z2xDN;
        Sun,  9 Aug 2020 09:43:55 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.10) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sun, 9 Aug
 2020 09:43:55 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] iio: documentation: light: Add as73211 sysfs documentation
Date:   Sun, 9 Aug 2020 09:43:35 +0200
Message-ID: <20200809074335.23734-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808171443.114c8e05@archlinux>
References: <20200808171443.114c8e05@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.10]
X-RMX-ID: 20200809-094355-4BPWLg2sk0z2xDN-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver for the as73211 light sensor provides the following not yet
documented sysfs entries:
- in_intensity_(x|y|z)_raw
- in_intensity_(x|y|z)_scale
- in_intensity_sampling_frequency(_available)
- in_intensity_hardwaregain(_available)
- in_intensity_integration_time

Signed-off-by: Christian Eggers <ceggers@arri.de>
---

On Thursday, 6 August 2020, 19:44:51 CEST, Jonathan Cameron wrote:
Hi Jonathan,

> Hi Christian,
> 
> I'll take this, but please send a follow up patch to add documentation
> for in_intensity_x_raw and all the other new ABI this adds in
> Documentation/ABI/testing/sysfs-bus-iio
> I should have mentioned that earlier, but kind of assumed we already
> had these documented for some reason!  
> [...]
> Insert them into the relevant groups that already exist.  In some cases
> it will just be adding an entry with no specific explanation.
> For the _raw attribute add a bit more info about what x, y and z are
> (basically just say they are from cie1931 (I think?)

I added all sysfs entries which were not present in 5.8-rc6.

Best regards
Christian

 Documentation/ABI/testing/sysfs-bus-iio | 26 ++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331..14ae4bf053c5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -40,6 +40,7 @@ Description:
 		buffered samples and events for device X.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency
 KernelVersion:	2.6.35
@@ -55,6 +56,7 @@ Description:
 		then it is to be found in the base device directory.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
 What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
@@ -374,6 +376,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -484,6 +489,7 @@ Description:
 		are listed in this attribute.
 
 What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
@@ -494,6 +500,13 @@ Description:
 		Hardware applied gain factor. If shared across all channels,
 		<type>_hardwaregain is used.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain_available
+KernelVersion:	5.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists all available hardware applied gain factors. Shared across all
+		channels.
+
 What:		/sys/.../in_accel_filter_low_pass_3db_frequency
 What:		/sys/.../in_magn_filter_low_pass_3db_frequency
 What:		/sys/.../in_anglvel_filter_low_pass_3db_frequency
@@ -1333,6 +1346,7 @@ Description:
 		standardised CIE Erythemal Action Spectrum. UV index values range
 		from 0 (low) to >=11 (extreme).
 
+What:		/sys/.../iio:deviceX/in_intensity_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
@@ -1342,7 +1356,8 @@ KernelVersion:	3.12
 Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to get/set the integration time in
-		seconds.
+		seconds. If shared across all channels, <type>_integration_time
+		is used.
 
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_integration_time
 KernelVersion:	4.0
@@ -1739,3 +1754,12 @@ KernelVersion:	5.5
 Contact:	linux-iio@vger.kernel.org
 Description:
 		One of the following thermocouple types: B, E, J, K, N, R, S, T.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_raw
+KernelVersion:	5.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
+		Units after application of scale are nano nanowatts per square meter.
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

