Return-Path: <linux-iio+bounces-8996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EAA96876C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B5B24599
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA519E97A;
	Mon,  2 Sep 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eohobcZm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926EA19E96A;
	Mon,  2 Sep 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279985; cv=none; b=DTKIdWbw5P6rEPOKxoTmAAoVR1CZJLZeBZszI9IGGOWvZZaWJDWw4KdAzdU1TjhUyUiGKqDVvBuKCnbh6yBmYYPlNikuZy2J6+lPEK1NDAdf2FpoasT2ffcjLvQz/GMjV2zjuTfEG2ArOAEoHIqOV96oRRYOB42K3GZdtLxyGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279985; c=relaxed/simple;
	bh=P/WjR7tOoR3+hQJPOsFg0Ba00Xt3tefhUhT4LAM8mno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvS1roZHcjs8BtyN1HYBIYoZeqQcw5Un/efF+HyNKdZq2MDweigjvDrpsku4Pe3lnSr39OZiQNliBHYz6Fll7PH4tVuvWBt5YxkDw/vBbzxTSMwSzYmEKikpbquAhaSFWZYGDt3BFmv1EF3rnfNRntFPoZbmwQw9GxgBTKxmf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eohobcZm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3024184a12.3;
        Mon, 02 Sep 2024 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279983; x=1725884783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haxmX6p2lihOUZmyKonHldfMHaTj+zVuxPjiPQTWX8g=;
        b=eohobcZm63/d9pyNbFXhPUB4sRIJg7N35r9oiNOeGleRlr2DNLpQOStsaFzgNHBT2R
         Yz8H5Cv0CYFqmAWNhD9/fD5960E38id+YYTr0hT4ff5936GLG+zZdJSuTEwNa1tS5Otw
         ZxJ7n8wfPVTUSQXJqLBYhtRieEwKID7c3O0VzQVZZ0OvdEDVjBDmC0RPnIWhwJ8N4E9e
         A9BVhpYn6HJcw3QS2t0cvosYrgLzWHTFtv9wuYnbFPlblm5eyWyeCne1hpDVRdi61Rmx
         due9NZzHduwxGu77qkbey1R7pkDg3j27irj9S5l//coepLjP9ury2blT+wUgfKZTSecT
         5CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279983; x=1725884783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haxmX6p2lihOUZmyKonHldfMHaTj+zVuxPjiPQTWX8g=;
        b=ZqgLsUNMn1HgP4YZZPqBL+8qzQmf5jCoXU/KyfHNRdsc7fzFieoOhU4oAR9muQe1h4
         GWLUfBrCDZYZLAoZLHCvFhgndxd0X+sYO+cY71d5/MXJm8vL0J68hj8Gt2I93TZQkF7b
         m1wXkKqkrL9l+Y0AyvtioeLVRznScMl5ngCM+REgtNOmzvcVVO2O/eJyrub4JvkxqjH3
         RQu9IWSNadt295ZTcU3Ijoc/W+Rvghq1ynKQsmq/jaZts5U+eHHQpLgOswl66oHv44cC
         6qpbogu01O43Ma536HscJmVOarxdJxnBTAsiHkEib/c/bOJYQF2cvhpuO/7XbJigRS18
         gwyg==
X-Forwarded-Encrypted: i=1; AJvYcCUPLSe6wI34ovYSUwNRHpomJLGuD/x+5ySTt16ap1Z9JwOwt26ClT6QXfqUapgBv53JYHKAJBER4l006RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5jXiPwXGErnMVqp3d5BdRF8L+58u+Ypr+mn7n2+xRlW5e/X9
	HMJKmeVdgmQirT+gDll4FSTWXwdeOh2Ga0Ormgw1tB+981476v++myny0QlK
X-Google-Smtp-Source: AGHT+IEzcv+DtNMVjJ9tluJLyVguZAE+5FHX3jNXHRduPWhsTYVNdkHtaJLgQkPo+wLxH1y2SxdvkQ==
X-Received: by 2002:a05:6a21:710a:b0:1cc:eaa4:5e49 with SMTP id adf61e73a8af0-1cceaa4608fmr13976771637.26.1725279983253;
        Mon, 02 Sep 2024 05:26:23 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e575b7dfsm6789541b3a.190.2024.09.02.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:26:22 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 0/2] Continuous mode support for VL53l0x
Date: Mon,  2 Sep 2024 17:55:54 +0530
Message-ID: <20240902122557.129013-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for checking the sensor ID by reading
MODEL_IDENTIFICATION register and seeing if it returns the value 0xEE

The second patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function.
Replaced the irq handler with a threaded irq handler in order to perform
I2C reads for the data. The continuous mode can be disabled by disabling
the buffer.
Added a trigger to the device for the continuous mode. Also validating that
the device uses the internal trigger provided by us.

Changes in v2:
- Added a trigger for the device
- Added a poll function for the triggered buffer setup
- Performed the data reading and pushing to buffers in the poll function
- Minor code refactoring

- Link to v1: https://lore.kernel.org/linux-iio/20240830201627.298264-1-abhashkumarjha123@gmail.com/T/#t

Regards,
Abhash


Abhash Jha (2):
  iio: proximity: vl53l0x-i2c: Added sensor ID check
  iio: proximity: vl53l0x-i2c: Added continuous mode support

 drivers/iio/proximity/vl53l0x-i2c.c | 175 +++++++++++++++++++++++-----
 1 file changed, 148 insertions(+), 27 deletions(-)

-- 
2.43.0


