Return-Path: <linux-iio+bounces-10133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC13990703
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBC61C20D36
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437B1AA7BB;
	Fri,  4 Oct 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE9DtDmZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC91487F6;
	Fri,  4 Oct 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054153; cv=none; b=G6Y8ntU9Rih/E6Mpp5BwJRy802MVST3s4vrbR8aE4o3Jy+BJ4wqyVY5Dt07M2R36cimDsDUIa4F/8EyMC1OffPWrtYX7GDgiwfseKYRjDaZAZX8IMy2ZHMvJ8uHHxQEBEErCMh2svKDy39r8GIyq947Ok59SUvHE6hbtx9frGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054153; c=relaxed/simple;
	bh=rAAQLIObmsegLhiBVxDAvwKlSFFPXFBRnka7LY9daxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrtYeWLm649xcd1Yd9bOdBTxygDkIQShGvBZWv/pboWfTPbR5DycplLjkZ8AjdwwEbrVnjQIrhK5TtnYAiNkiRJ4jTuT3W+aTYfBvGtoKtzX1j8Frb/eXmtA5Ov0S9xbwKn/xipK4xiXdTlAVOc1Z2unnVrjkk6vFy5Uwx1mmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE9DtDmZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e28ac7b12bso1292593b6e.3;
        Fri, 04 Oct 2024 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054150; x=1728658950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0807RzwrqRttB3uYfgusJXG/2zknbvieHehyKQUiVIo=;
        b=DE9DtDmZZx7tc8GIW55A50Snm3DQJnvkkXJejCi4sscJHtAGg4Pgh1h8fJbstJxfka
         gw+Rn7bTGH7J53GH8zV9TVwC23YCWjytg3lyusnUmaemXsN4+f3bdOsW0TDM+NOxYwc6
         6cOEhrzObVn63M7JkPCdd0VxAaaCgG9Dv8jqUH47b7No7zTSrI8N8kzvx0bsrHwrBH5G
         CAvCJp+S3Yy0Hd0pWyttyTxGXhBUXUSmgFDz3HLXFOONNee8lo90EY2eZ6wLqpcHMBFS
         vZnBuTAuiJ/Qsdjai5J0GTVEPjHZoCo0jNxd4A9hCzxiq1ycB6QeDDq+M6+vT7iHxD65
         aIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054150; x=1728658950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0807RzwrqRttB3uYfgusJXG/2zknbvieHehyKQUiVIo=;
        b=TZsG5UEXHhrZYgrlwmxXlNiiGiT5rXFwAg87uL5lS7u4S/5/AAKD0mp37b1vrlfl7a
         BzdF8pr7nwqiFknPJ/wQ5ElvjH7qvd3z1ef7kI0P7I6TnoNdeufCu9euFkGzTP3M3mk+
         9Gx7x3t3ovEyqSsAjT5EjPI4CkY0AgfQg8VPixkpRt5GMTCX2vyb0LOIU+GA6rSbe6/W
         cIkzuZMas+6WVHeFIBGgJSWZ5ijWBamnocSyJpYAxYsayE1dp+PFhIsY0aWGBNzRrsWL
         +AT58C9WaFCO5LE9wTng1brDHr4ycS34362d57OrbIDyNfANM13nNi2tsyOUowoxGFay
         SYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpr1WaibuMtdz+7vSPjYNqSGRudZPczHfK4lW8b8anJg1604Wf9kTJCb4P2gD34+Uc9JortPZMXeO+3To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYJZqLb+4Rh1GLe/aleBihKel2UCZY9kD389Dl5ljmjhnYwBQ
	rHx732Kqw+0xTU0USTg8ejTH3EShSKPDHqf6ki26lhqaccKE2o04aUpt5VoIYMg=
X-Google-Smtp-Source: AGHT+IE/8f/AnfuymvZwDixwp2E+YVYohx97oZuHhRJNtLGRcQjKxrA/0Kbe1obDLu6b6/UeZAUOgw==
X-Received: by 2002:a05:6808:30a0:b0:3e3:9e78:c5c5 with SMTP id 5614622812f47-3e3c1550838mr1916989b6e.4.1728054149930;
        Fri, 04 Oct 2024 08:02:29 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6c34127sm19979a12.67.2024.10.04.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:02:29 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 0/3] Interrupt and Continuous mode support for VL6180
Date: Fri,  4 Oct 2024 20:31:45 +0530
Message-ID: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency
(inter-measurement period) of the sensor. The values must be provided
in miliseconds. The default value for the inter-measurement period for
ALS is 10ms and for Range is 50ms.

The second patch adds support for interrupt based single shot reading.
We registered an irq_handler that fires everytime the data is ready.
And then we read the appropriate value in the `vl6180_measure` routine.

The third patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function depending on the `active_scan_mask`.
The continuous mode can be disabled by disabling the buffer.
Added a trigger to the device for the continuous mode. Also validating that
the device uses the internal trigger provided by us.

Thanks,
Abhash Jha


Abhash Jha (3):
  iio: light: vl6180: Add configurable inter-measurement period support
  iio: light: vl6180: Added Interrupt support for single shot access
  iio: light: vl6180: Add support for Continuous Mode

 drivers/iio/light/vl6180.c | 267 ++++++++++++++++++++++++++++++++++---
 1 file changed, 250 insertions(+), 17 deletions(-)

-- 
2.43.0


