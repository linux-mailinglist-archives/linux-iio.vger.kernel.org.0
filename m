Return-Path: <linux-iio+bounces-27325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC8CD7EBB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 03:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18C713002886
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 02:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51032BF011;
	Tue, 23 Dec 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="B43PUX8R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D023E33D
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458533; cv=none; b=kryLI9zepuPV6SgdjRyalpA0fWhoYru/SK9ZGSvxLIGB2DpuMOPNjfUBKfnpId/6++KRQv16mP/fWRpCnZtNyMBfCaoq81jjeF/P7fXcBUXJQeUQqItqtz7GV8JB4z+Fh1C6MKWqPCScucDm8uiv1j/dFQDb2LJpOw5CDrw88KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458533; c=relaxed/simple;
	bh=FmINFl66x7c6O1WwsFnvRfuI0TeWpe8TQzvCXdh0cxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8aLBRXXIUKFYqiu1dyN70qjwJXW2IDlPWGdCnz1s3QqJXrRkBD4yO7u1CRJC6EautVxA7xNU4qp2Wuj4N5UIbWYSGyq8ksK8pryXr1qAgMiUIFxCdEO59dR/JjTIM7oi/ek+595WYwDPhkc2XZ+O4+x1lvcEKh2+snhdV1P5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=B43PUX8R; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c15e8b2f1aso109894285a.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 18:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1766458529; x=1767063329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPXtsmZwqmszy2Z3ad4yZemQBr4otwPEMwkLHzGFQDs=;
        b=B43PUX8Rmk0ANRZRDllquMSdCliB6TtdQyoG7Ep3thjUmw7n1Jmx4dIqw575/g9aeG
         QlTtg2ckQ7vhOITLqiHmsOlm8ZZZxb7/peghx6YV/TJAoehwutBsApz/yuWyOHS2BUVA
         D+P5IEXPaRz3Wa2hiPPj6JM91+5iYSRuzJGYLFaHPWrx+yA/m95sBXFKTMujpve9G9O9
         l1kAwdS//DUlpV+Xs7SKKlPTyv+GYfphASPzzlypJxPK0uvgpUJMSvu+m8Q+O3ehbc4D
         IIAcS58xVkhDTZqsbVO2XGIazsk3z1XZiQORe//EN1P8UDVtBfE3jlK+q6WcsQL+CKPa
         B/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766458529; x=1767063329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPXtsmZwqmszy2Z3ad4yZemQBr4otwPEMwkLHzGFQDs=;
        b=IdFXj2qaLfuUoSIp/QV+cNeiF9oejohuesXPGb+k8z5dwdnb42TLjeJi1ouz66eHtT
         79bDBWDX9zLHFF05dC1KLulrCs+7p++eFw+FH0ri/IQzXM0CJVhkPFjer4sKaIQRq6tG
         +Eemv0kA1dKsxMmZeZB9Vm0nRTImW8dY+NPaZozqCWNt2kx5fepwLkx1+lxcdlNRoJqV
         x+6isSK3+78lzHGv10vqZ6ji2+d22XdijUxy4fwPSxSafoTHQzReytSg6LgCGJHgbibt
         MC4sf4YEXMMcjaO1MwRdxn/GIFzxkxWUX6gfQg0ptqaOZKATRcLEVFSJ5kGcoRnY43Yl
         JdeA==
X-Forwarded-Encrypted: i=1; AJvYcCUpCblq+n/U3Fxru6H86oFPJIRGpc5P1fZoBw7fINSFiSnGIgoYL0wmnxxpLiqKZBEdb0j9S0zffLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlBpYf8bh1Lf6ZvUJrdDJf5KmNtU4EW4VwLaOtqt8OhZdyoGG
	Y0qbjt4TIs85KDSPskyAaTGckxlFIqksNAqQYLkdFqYMAcigynl9/WkDR7hnlMJehQ==
X-Gm-Gg: AY/fxX7lk3NrnzqS7Zi1LqYhkT/B16DNI5wkNjL8n5jQXPmU4LEplA/RCT+dEayQzHv
	+N6O7G0QnE6mldlA/BrHqmIaOO76Lz0ZALdR6Rj0e5T5Z8j7Q5KhLVpoZR/mo5O+BSSvPQyVM8Y
	x/T4NHmsIBL+68+DAMOtCmKbHSc2GbdAQFRDqXz0SR148pjAV83ahtTY8Ornl+3GzYmnI4EtlGC
	yCW9DQkHrWwc4mArUQrqcnK8DFUaPY/orM7FJt2j0yGPXSflIOxDLF1TEncQvdWoCcuFpoZ+LsK
	UjoORE8vSWL3wdXoVnBUbGm1xqXZmMcOPs2TxdYGyFv79LChSHaboHOzR1vXXfn8zz8c/xLM6MZ
	BS4W936xW4smCWgtNq36+kIOU1Vdf03evp41xPxkqlt1KBUBE2M/nhZRUDhyJEdaQPLRit0lBvU
	fQPQy2aPcfMHWoJn7tJt59Kw3Eqls+53y4kK/+BgyQNzMzTnX/Wy6eLSVGHDzZHNG9MQ==
X-Google-Smtp-Source: AGHT+IFMQBuJKG+s89ytfpim0agf28VsA4eYpJoXXbIrx917beJ85V1CH+cN07TPoFVi29t0qUWpOg==
X-Received: by 2002:a05:620a:444a:b0:8b2:e986:2707 with SMTP id af79cd13be357-8c08faaf129mr2112728385a.45.1766458529319;
        Mon, 22 Dec 2025 18:55:29 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f8572sm952775585a.25.2025.12.22.18.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 18:55:28 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID
Date: Mon, 22 Dec 2025 21:53:49 -0500
Message-ID: <20251223025351.3099978-2-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch set adds the alternative identifiers for the LSM6DS3TR-C,
just like the windows driver allows.

I have done due diligence, and verified the assertion that the SMOCF05
is also the LSM6DS3TR-C. This was verified by looking closely at the
Windows driver, which also uses the LSM6DS3TR-C device identifier with
that ACPI hardware identifier.

From looking real close at the Windows driver, I am intuiting that this
different identifier is used to change how the driver behaves, but does
not materially change how the I2C device can work. Though I'm not 100%
sure of this assertion, I believe it does not matter at all for the
Linux driver.

This SMOCF05 configuration was tested on the Minisforum V3 SE.

For completion's sake, the device's DSDT data follows.

    Scope (_SB.I2CD)
    {
        Device (STS)
        {
            Name (_HID, EisaId ("SMOCF05"))  // _HID: Hardware ID
            Name (_CID, EisaId ("SMOCF05"))  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
    
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CD",
                        0x00, ResourceConsumer, , Exclusive,
                        RawDataBuffer (0x04)  // Vendor Data
                        {
                            0x53, 0x4C, 0x41, 0x30
                        })
                    I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2CD",
                        0x00, ResourceConsumer, , Exclusive,
                        RawDataBuffer (0x04)  // Vendor Data
                        {
                            0x53, 0x4C, 0x47, 0x30
                        })
                    GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
                        "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                        RawDataBuffer (0x04)  // Vendor Data
                        {
                            0x53, 0x4C, 0x41, 0x30
                        })
                        {   // Pin list
                            0x0009
                        }
                })
                Return (RBUF) /* \_SB_.I2CD.STS_._CRS.RBUF */
            }
    
            Method (SLA0, 0, NotSerialized)
            {
                Name (RBUF, Package (0x03)
                {
                    "-1 0 0",
                    "0 -1 0",
                    "0 0 -1"
                })
                Return (RBUF) /* \_SB_.I2CD.STS_.SLA0.RBUF */
            }
    
            Method (SLG0, 0, NotSerialized)
            {
                Name (RBUF, Package (0x03)
                {
                    "1 0 0",
                    "0 1 0",
                    "0 0 1"
                })
                Return (RBUF) /* \_SB_.I2CD.STS_.SLG0.RBUF */
            }
        }
    }

Samuel Dionne-Riel (2):
  iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for LSM6DS3TR-C
  iio: imu: lsm6dsx: Add alternative ACPI mount matrix retrieval

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 1 +
 2 files changed, 7 insertions(+)

-- 
2.51.0


