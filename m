Return-Path: <linux-iio+bounces-27918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF0D398F6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8773330078A4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3E242D79;
	Sun, 18 Jan 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnDUeSD2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06801AF0AF
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760210; cv=none; b=Di0M4jyyZCG9/aKRUY7yP+g+92lghSWtEQxS8waK8VVTW55T34mdmxuxEA4qQ8zhAhLQ+3ylX0dH0dWKtJSOsSZpodEza6RQpbYFC3HXhFK7v80ewzafmSU9PhendwcA3Ikr+IuxrnOr6nkLhv5d6NsDBRYr6l0dZJl6Pc9dejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760210; c=relaxed/simple;
	bh=iB0/4hF5veoSF+PlSaugXG6VudDoIwCeU5fV15WMNQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qSCzlG8EQ9nqF0SbEW+MHGLgv9HjsS0a1ZL/mapQN6TpypQWSxMdoYbD4454HuWuEbDBYUPCgOKpTycXZrhBXnlAjp+dRCBIx+cbgt8XYyznM846ybo3ILlirP050hjwsteR7bfuXmETzPLz0Cfa7G/F1jAYD4NIpMANa+0406o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnDUeSD2; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso4233055eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760207; x=1769365007; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVYBBkubRi7EdkLJ1LoOm8/Bg0yODBTjsMSrjuUr85U=;
        b=bnDUeSD2cLOxjuE1KwABx8Zq51+zAt/yH5YJ+hQbdXqGtxS5VrgnpNIERNfwh7t2mE
         S7VtdvUFiwPrBqyvPiVIsFk1CQu4++YCrIJh8tgfvhuRSQ698eJ6lD33vnStmiE2msUt
         iTTTIEu1yq+cVFL8vewuK+Q0EOPO8ImpzmoVGK36YAyCVpAdDTg8WCQ+vNVvZnEcjqkI
         HUC8A1Z/QS/Solc+LvxYJycgZ23Q+50gHttfY5FUHa+kyGG7h5HB3otLdp+ZnQKngISa
         R2JJnflt4GK1Wzp/Wv0kXEDYAsXjiKU4M01TOYIZqSpzPA6Jcq8w3xg+NQqqUM+yhV1l
         zbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760207; x=1769365007;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVYBBkubRi7EdkLJ1LoOm8/Bg0yODBTjsMSrjuUr85U=;
        b=FxaAnLdPbN8k+GET/KuOMtzeUODCVzbEn3nn1KlKD2OlZFGMKVsyWLMjf0gyG3szCc
         VV7XoHekcmvr+RyLjUzBaJ9kLJsixEEqRtulP6kb6GyKRX8TVTjnV+zf3rjrHNnYXsnb
         cSALEYtzZ0tmFatxMYYh/sbZj/LRjMaLH1oHNicsyGjlzXknmuEXYyiR/XhQWU/gvnjT
         4qmhZdIxfnRxdKhQauU/AdKWcDo01/8wQZ48jOkpAw+e9hjvzoaRcslOElChPtKj3V1u
         wRsu95ALjTAvTJlEFmVG+RcCY/9KD9yYECoKP88/ZJr+TYCc8/x7rgdKC1aY9F7lfFTa
         7+eQ==
X-Gm-Message-State: AOJu0YwWz51Racm4DDccQuCDA4Zpc8xyr3lpUcBQAhn7VDazcrfMT98B
	jD9ZNgWkfWRWDtifNElhTA/m15nmVBJN+8BP7g9WhOfUESRGzZfe/bigaRgh+qli
X-Gm-Gg: AY/fxX4nFbolgE9y4No2F2EqfvtRISuCHqOv2gDfo+U4KWtYQwbx03okxmp83yCI/x4
	NyQ131gXrcXHcRUJ7i6c+fbWUaCFfkO6IU5lrfzE80Q7riYPPIZa6l/O34Zy98It481byyHb3RM
	bAKS/xP3Y0s0SqicjDwtnIoTgt9FK2Dw/YrczbDGhsc/4Li7QH+mpXn0do2Wqr/kULnESqgy6CO
	yZZckgFu25SvTJaaF9oLfk6AOf8lzCHI99DeT32r07kqiTIQZ2rpcBjYSnQydTGfqtvqOtE3PFG
	Di4UqCDOzIhJ+Gy2TsM0JR/+iBlR8/jwPEfiihlkbRFlYg+rvuQ8bcRveHHzEotRaIjADqbugOC
	/W5uzKefoCfESWS0OgMaeFImFMMGMYFGKqel8RqGvi2d6NXc4VusFol8s/BZiiSnjX8Pro6P4kn
	kvzNrucGuP0pMeI7IN8/A=
X-Received: by 2002:a05:7300:690a:b0:2ae:59d3:46d3 with SMTP id 5a478bee46e88-2b6b40f3892mr8462070eec.25.1768760206992;
        Sun, 18 Jan 2026 10:16:46 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361df88sm9825267eec.18.2026.01.18.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:16:45 -0800 (PST)
Date: Sun, 18 Jan 2026 15:18:36 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 0/9] iio: Expand IIO event interface for real-world
 unit handling
Message-ID: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch set adjusts and complements the IIO event ABI docs making them
coherent with the fact that not all threshold value attributes had a _raw/_input
indicator set in their names. In addition that, the latter patches on this
series update the IIO event infrastructure to actually enable drivers to provide
_input threshold value attributes.

I'm actually proposing this set just for the sake of solving the event ABI
naming inconsistency. I recall the event ABI was a bit puzzling to understand
when I was having a closer look at that a while ago [1].
[1]: https://lore.kernel.org/linux-iio/cover.1703013352.git.marcelo.schmitt1@gmail.com/

Also, I'm doing this set entirely on my spare time and just because I wanted
to have the ABI naming inconsistency fixed. This is also a late reply to [2].
[2]: https://lore.kernel.org/linux-iio/20251109164312.781de64c@jic23-huawei/

I've tested this with ad7091r8 driver and result is:

Before event extension (current IIO teting branch):
root@localhost:~# ls /sys/bus/iio/devices/iio:device0/events
in_voltage0_thresh_either_hysteresis  in_voltage4_thresh_either_hysteresis
in_voltage0_thresh_falling_en         in_voltage4_thresh_falling_en
in_voltage0_thresh_falling_value      in_voltage4_thresh_falling_value
in_voltage0_thresh_rising_en          in_voltage4_thresh_rising_en
in_voltage0_thresh_rising_value       in_voltage4_thresh_rising_value
in_voltage1_thresh_either_hysteresis  in_voltage5_thresh_either_hysteresis
in_voltage1_thresh_falling_en         in_voltage5_thresh_falling_en
in_voltage1_thresh_falling_value      in_voltage5_thresh_falling_value
in_voltage1_thresh_rising_en          in_voltage5_thresh_rising_en
in_voltage1_thresh_rising_value       in_voltage5_thresh_rising_value
in_voltage2_thresh_either_hysteresis  in_voltage6_thresh_either_hysteresis
in_voltage2_thresh_falling_en         in_voltage6_thresh_falling_en
in_voltage2_thresh_falling_value      in_voltage6_thresh_falling_value
in_voltage2_thresh_rising_en          in_voltage6_thresh_rising_en
in_voltage2_thresh_rising_value       in_voltage6_thresh_rising_value
in_voltage3_thresh_either_hysteresis  in_voltage7_thresh_either_hysteresis
in_voltage3_thresh_falling_en         in_voltage7_thresh_falling_en
in_voltage3_thresh_falling_value      in_voltage7_thresh_falling_value
in_voltage3_thresh_rising_en          in_voltage7_thresh_rising_en
in_voltage3_thresh_rising_value       in_voltage7_thresh_rising_value

After event extension:
root@localhost:~# ls /sys/bus/iio/devices/iio:device0/events
in_voltage0_raw_thresh_either_hysteresis  in_voltage4_raw_thresh_either_hysteresis
in_voltage0_raw_thresh_falling_value      in_voltage4_raw_thresh_falling_value
in_voltage0_raw_thresh_rising_value       in_voltage4_raw_thresh_rising_value
in_voltage0_thresh_falling_en             in_voltage4_thresh_falling_en
in_voltage0_thresh_rising_en              in_voltage4_thresh_rising_en
in_voltage1_raw_thresh_either_hysteresis  in_voltage5_raw_thresh_either_hysteresis
in_voltage1_raw_thresh_falling_value      in_voltage5_raw_thresh_falling_value
in_voltage1_raw_thresh_rising_value       in_voltage5_raw_thresh_rising_value
in_voltage1_thresh_falling_en             in_voltage5_thresh_falling_en
in_voltage1_thresh_rising_en              in_voltage5_thresh_rising_en
in_voltage2_raw_thresh_either_hysteresis  in_voltage6_raw_thresh_either_hysteresis
in_voltage2_raw_thresh_falling_value      in_voltage6_raw_thresh_falling_value
in_voltage2_raw_thresh_rising_value       in_voltage6_raw_thresh_rising_value
in_voltage2_thresh_falling_en             in_voltage6_thresh_falling_en
in_voltage2_thresh_rising_en              in_voltage6_thresh_rising_en
in_voltage3_raw_thresh_either_hysteresis  in_voltage7_raw_thresh_either_hysteresis
in_voltage3_raw_thresh_falling_value      in_voltage7_raw_thresh_falling_value
in_voltage3_raw_thresh_rising_value       in_voltage7_raw_thresh_rising_value
in_voltage3_thresh_falling_en             in_voltage7_thresh_falling_en
in_voltage3_thresh_rising_en              in_voltage7_thresh_rising_en

The difference is the '_raw' element in thresh_(rising|falling|either) attributes.

Why posting it as an RFC?
1) ABI changes a sensitive topic.
2) There are 77 drivers that will go through collateral evolution with the event
interface update. A 77+ patch set is probably not a good idea? I recall the
claim_direct stuff was split into 2 or more patch sets. This might need a
similar approach (if accepted).
3) My coccinelle semantic patch does a nice job in updating the vast majority
of the drivers but, it produces diffs longer than needed. E.g.

@@ -844,7 +844,8 @@ static int adxl313_read_event_value(stru
 				    enum iio_event_type type,
 				    enum iio_event_direction dir,
 				    enum iio_event_info info,
-				    int *val, int *val2)
+				    enum iio_event_unit unit, int *val,
+				    int *val2)

could be

@@ -844,6 +844,7 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 				    enum iio_event_type type,
 				    enum iio_event_direction dir,
 				    enum iio_event_info info,
+				    enum iio_event_unit unit,
 				    int *val, int *val2)

I'll try to figure out how to make it generate smaller diffs, or do the changes
by hand if needed.

One more thing is this doesn't need to take test bot time as this breaks kernel
build without the patches to the individual drivers.

With best regards,
Marcelo


Marcelo Schmitt (9):
  iio: ABI: Drop unused in_energy_input
  iio: ABI: Accurately describe in_distance_input
  iio: ABI: Accurately describe in_illuminance[Y]_input
  iio: ABI: Slight readability improve for event threshold value doc
  iio: ABI: Update event threshold value documentation
  iio: ABI: Adjust event threshold enable desc to unitless thresh values
  iio: Expand IIO event interface for real-world unit handling
  iio: dummy: iio_simple_dummy: Update to event unit expanded interface
  iio: adc: ad7091r-base: Update to event unit expanded interface

 Documentation/ABI/testing/sysfs-bus-iio     | 29 +++++++++----
 drivers/iio/adc/ad7091r-base.c              |  7 ++-
 drivers/iio/dummy/iio_simple_dummy.h        |  6 ++-
 drivers/iio/dummy/iio_simple_dummy_events.c |  2 +
 drivers/iio/industrialio-event.c            | 47 +++++++++++++++------
 include/linux/iio/iio.h                     |  8 +++-
 include/uapi/linux/iio/types.h              |  5 +++
 7 files changed, 77 insertions(+), 27 deletions(-)


base-commit: c30e80d68a7afb334fde7147ee0106f25dd58d3a
-- 
2.51.0


