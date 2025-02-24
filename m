Return-Path: <linux-iio+bounces-15999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B50A41E97
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D777A13D9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C851248877;
	Mon, 24 Feb 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Jnc6gTSf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD06248866
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398781; cv=none; b=oKvS41/aL7Y5AT55iUm+HzIsMI2bfcED3Zq3eZuwvR2eWcwOy+AQGwzZSsDKzEI49VbBU/FHD7Du8YOB5yZJ83XMl71mWQPAgUvKP75QiL4PN+WghPiRXsfUt1zRybUHlA9lK8dqT0xot7j/lXvanRMz7WgzANNra2Kw+5/ygFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398781; c=relaxed/simple;
	bh=+Agf8UKAqGkJL+3vH4U8xbAblWaOBO6N6JdSJ1Tt5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgfJNt/P83QJHVD/JTDieEGfa6rcgl5MS50Dz491cj4U15kE+VxDQf6X4oWDeYWBWADBSJ5jRUumqCPdmD5Eb49wpOSa6PbtBbr/OzVbGbU1FYpAFiLRjvs5i/3knA/3yNp5HWHS2qsv50bwvOl+v4GdqNNuk6468aEtBwRSUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Jnc6gTSf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec925a135so19462266b.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 04:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740398777; x=1741003577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo1Gcpi1KHfmTJdi6Pn8yyGXw/q62BzySSHgB6HQ+5Q=;
        b=Jnc6gTSfcUR9TI16u3EpYvVJD3x7xViIIqLxSbDNkqMU2kZB1l3AZ8+7Vl4RgxWDNW
         vSPo2PUQ6tlM7Yn4oB8VqqNE+uXDvF1yhkzQ2r+3RNDW1eM6qDyV1nT0Z57raOlauxBI
         BVMlINeV+SVrhMiSlNEjOwnpCtFUdUuoPvi4JcmkkK9iJAhwTXGCTDmNfYeSfbyhol5m
         XwUSVb4jaRlmzE4FXfW6PyhCunq24odyi32lCakez4OUAs5GNNA1CRpuI7F62PyrCD07
         ScPBTzl57ageKhrBYiRVCMov5jKwpGIGJwFz/aenkbTTHAuzbKTb5h4gt54m3u8a/84C
         j1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398777; x=1741003577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo1Gcpi1KHfmTJdi6Pn8yyGXw/q62BzySSHgB6HQ+5Q=;
        b=MULHY48UkUQJeZUY9MII/mJGgqVdI4AXPHgZ11auYk0TQUQ1hGCCZpesvcH+8HNEd3
         8xN4vAJ4xyLzWBfvnJ858KuWsRaYUD+SAfUz8QsdW2Odf48PYV9Zk0Ams2j8efi876lt
         ajmm3BUh5sb+A9/6lcC/AvIUf+UIuOr7TdXdJRTn2MQDRsTHdniy8kxneSX3SFQd3N2J
         dBp/586VqxOhKhpOvGdGbTgQymqEKJcTtXjbuct6rOuReJHgU2T0N+pOHBY9pl0VO22N
         aXvSNFT167DffElWsEDe4e2I8T4vsy4KTyE4SCSipl/uUT4A9SDn4oAzZpltuERyzLQy
         nuiw==
X-Forwarded-Encrypted: i=1; AJvYcCV00+h3vtUEt3BYy7U8bBL6G7duaevVimULq474S4d7RJ3AcaO0+sx4c5AN84GdGmH/7XaEhUMEX8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7vwx3//h3XSZw5H+6fkQaq3zou8G8tWcCoNOP6tf24WYn4Po
	dGsc77dR23KLJaZ5QjCtDIsBWNmz29S1c9mDyGXxlT/0ew+wOjMSTdMfIB2VmAk98o3QKxEMFvg
	WgvM=
X-Gm-Gg: ASbGncuat197bWe+NcmUVERvDNbkF8F87g7kLNf0hvUdQh5CHv/fnj5ISHoLRo3vmSv
	hYSg11RsDmtpeX7E0o+LTHnfhSegI7uB1WrbLu1bsooxyx9f903ORmziLlhJtgVVMSeTDiMVBWN
	/2dRnnn1VspuyeHQ6u3Kk0MRHtI30RO8VEsEUZMKNWBrUN7w53+iBO72Wv4CaBemBk/vei3r92i
	CCU4XJWx6/7BSkeieVoFJZ4L3DBJT9KsiMEq69D1/NSGvg7D3He9aCKk/pb+occAYcv1crY5ncV
	6g+iiLMDdUmHJ8yQ+CEhP2H+t5HnnHfn18GIn1+Vk4lbsKAGI6ayDPQ=
X-Google-Smtp-Source: AGHT+IGDJzU5NaW2phimEssVYOYVx4z5a+NFOew8SQJlOCu85fp72+5lccWfbGDbcb/fSCXbV+iifg==
X-Received: by 2002:a17:907:7f8a:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-abc096d6e93mr1477881966b.0.1740398777012;
        Mon, 24 Feb 2025 04:06:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb978e2c9dsm1598901966b.65.2025.02.24.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:06:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Mon, 24 Feb 2025 14:06:05 +0200
Message-ID: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v3:
- in patch 2/2 use a devres group for all the devm resources
  acquired in the driver's probe

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Open a devres group
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 117 +++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 42 deletions(-)

-- 
2.43.0


