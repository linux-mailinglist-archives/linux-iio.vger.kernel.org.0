Return-Path: <linux-iio+bounces-10604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3E299E244
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71C61C21B8A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C261D9A45;
	Tue, 15 Oct 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eW2Bhrer"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AE1CC8B9
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983350; cv=none; b=E37MAF0IdDY+Kfau7h0htbxtvFwuP0BinrRCRUPRVjHDgphq1+sx3DKEZf+Hzd6EUNivJt5KGoP2UmzKjV19e3KSMtTZ6HUv7B96kMEXIblY8V2/kXgDLuGJoi3N+4Anzyd1ReCtcJ94928uaMMBwg5LTlAL4l3cqwg9Bo4GlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983350; c=relaxed/simple;
	bh=LtzIlROurSiaY9C3qcwo268+cnEG6r5bRRRuf9pnuPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QlhTppS/rjB7qXC7skvwAjK56HU9lbyDBoYOF2dHKcEZ/gSfGTaoymqxZDxgIQy1FLacPviZIQXiezz89DOIWj++gchrEqcM9zf00Sr7jQAHWO2UsZlm1GKcVV9eHTrgdV6JRlSdf1iK/HX89xCln8qwdIZkRxgvWLgNAoAT5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eW2Bhrer; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43124843b04so27457515e9.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728983346; x=1729588146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo4oi4aky+ivt1/kLLwbqQ8oWOYu1u0gufAG02tiQEU=;
        b=eW2BhrerPpfsGyT/ac8N3PHatG5Tw25Zn6rKaw3/3X/cRfw95zsKTn8Z74KlaT+aqI
         YqPL77VUIss/X7R+ioQBFpwzll88bUUfV96zGSbpE3dvZPlN3v3gL08JKs9jiWx+3THG
         Ynq4gBrPg1rYPAqzbKdD3aeR8+Y+JdUzpl7Q2xmhIVmfF0yo/m/49I7QR5vq79f7YD0p
         2JaCi1xoxkMwqbjy9O897ZeYLGH5BPm3ZKI2It8oJ9vXZcJfax52wuqXQC6d11YgVnmO
         6nHSxm8Ct0mrhsf9uWm7zZFUHtALkRx8XZHP0Q1IUgeFDviRckPreptTMCr40bUGcdEY
         BZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983346; x=1729588146;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo4oi4aky+ivt1/kLLwbqQ8oWOYu1u0gufAG02tiQEU=;
        b=k36z+AknkOPBpHQE+11sjgcnH0PA8WYwiVYdZQ0zJrZlH6vhSWT8b9JP9ON7rMHIkO
         aujfzY72x7/RwByBzoU2/B7niEqPnSXBk8d6N/Vpmz+POIkcDyEUK/Tp9j/xOngrUIea
         dchVc/m2z2DPYmMVk03vZV+hAQn4GatL31zVC+QoHjB9jULT/wuxwfahBpE+NZW4zo7l
         CI4Ou+4NPOY5seAPREnSrjofmrOubRYBpwWLTmWeVKnsWZpAG1yHcidRQDxQNPaw4aGW
         q0fADOppLJafVHSdmp0lES0IJdW+MNIjtlsCKeQZQIP23ldZlH1CCfCha9XbdKS0YHkO
         ddYw==
X-Gm-Message-State: AOJu0Yw4bzSE7JQf3t6LvLTexLUdmRUm4NJwlQ5+CnGVgzEFYAkljwk2
	S6XR8G8hI8tgj3skTb62CrdLCI10Oro1ZBolMwCBiE/WllwhFLgYCnT63Oc/6w82EfCmnzSJH5c
	vc9o=
X-Google-Smtp-Source: AGHT+IEilcQqGZU77u5s49pKan4uTKo0ZlBRqQasDoTCdTFyKhvCZ4pBrcIKYkMF4Iz33U7oU75T6A==
X-Received: by 2002:a05:600c:1551:b0:42f:8515:e48c with SMTP id 5b1f17b1804b1-4311deb6142mr126238045e9.3.1728983346102;
        Tue, 15 Oct 2024 02:09:06 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc123dasm1012882f8f.94.2024.10.15.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:09:05 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH RFC 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Date: Tue, 15 Oct 2024 11:09:05 +0200
Message-Id: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADExDmcC/02PwWrDMAyGXyXoPIPlOLWXa2EPsGvpQZaVzbA2q
 Z2WQum7T2s32EGIT4Jfn27QpBZpMHY3qHIprcxHBXzpgD/p+CGmZGVw1nm0OBjKoY9WW9aik/8
 Bb9p5Wea6GvSZMQhb615BM5YqU7k+8nfw/raF/XNY5XTWW+vvJlETw/PhUNaxi0mojyESDoiJh
 TK7KU0u+mRtYh7IiVKG/45j9zS0/s9Q7z60vvQ9029C6DcDT5FovCDs7/dv9Ue4dfsAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

Hello,

This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
which are quad-channel precision data acquisition signal chain μModule
solutions compatible with the ad738x family, with the following differences:

- configurable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This series depends on [1] which fix several supplies issues

[1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (4):
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 117 ++++++++++++++++++
 Documentation/iio/ad7380.rst                       |  15 +++
 drivers/iio/adc/ad7380.c                           | 135 +++++++++++++++++++--
 3 files changed, 258 insertions(+), 9 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
prerequisite-change-id: 20241004-ad7380-fix-supplies-3677365cf8aa:v1
prerequisite-patch-id: 6d87f69eed38931663a1fe4035d92bdddcc06da2
prerequisite-patch-id: 337292de00e31ecc2f71eac207542f236d8c0ff4
prerequisite-patch-id: 7dee57142d0d12682b0be3b62f1c16851aeac069
prerequisite-patch-id: 4ca1d234fa53f27d4e73150df5b00e245a142f67
prerequisite-patch-id: d42f3c478b92a6f97194853fac271add226803cf
prerequisite-patch-id: 972bdbf06bafa7c56f604dbe8eb7d236aadaad99

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


