Return-Path: <linux-iio+bounces-22377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FAB1D3AA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398EC188875F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB5226CEB;
	Thu,  7 Aug 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csKCKZsg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F81DF258;
	Thu,  7 Aug 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552960; cv=none; b=Md43opHTBzMdTum2kYgnQjHU5neBUvQQ8wZ0Hulx4aEzguzvLE3j+au9nXUp2ynqTwbCjWozJANVyljkvPlcQWw+9eeriNCN5Y18P+uFOlzZjhL2x+3ZH39tzc4n/eiZrYc6xnNsyRB0hUkM8SoVd/F/A9Xq4elhsghfZyAfz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552960; c=relaxed/simple;
	bh=jaWHl5C+qwF5yMB1bbOvMBN6NmTUXEldg5LIb6dZ/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H27cUei72v41MLHM+1eTyfXFy0lTBgwBPMi3Hz2CKZOO+6sgs5aDgBvX4kgCRo8VPAdRrllKVJPeYXsvGAgjNccSPkNIBj6kEUSh1c7OPh99RYPTjhocLxhp2CH+lklBwXBBuLnMEOynauqlnYhscPbG6AfVk5bodAFPG1sr+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csKCKZsg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b792b0b829so513980f8f.3;
        Thu, 07 Aug 2025 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552956; x=1755157756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbiXVuMsAdtVfMvlH4oVO0pj5XaDz9g3ljq293tZP6E=;
        b=csKCKZsgZA8ouzEOupwJrmbNbEBuuSFKJW08AUfUSPKZhQrJsTO514tXkrtNgS1l2T
         b2aet2CvI8kJrf/y/1gOIdzAKp5iK7NBYpWs6CrYyYeKbLTgttscsq6NzO8tymZox5eM
         7FfFbuueuHcjA2vCs3351UCuEQhspMWc2ySL5YuYDnspbCGBW6jAmdT6cY6y+LYd4l/o
         838qpg9I8O2rnJxXBIHXmjztN5OM5K7naCUwas3FvD9fhcVi5fkCFHrO5yhmJCoPfa3i
         C+ohGFebSLz5+KnefWZJru0C6WcWtOlhPG1fQtkwmhPQw3aGihJG3lJ4KO2Yicf5meJP
         8PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552956; x=1755157756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbiXVuMsAdtVfMvlH4oVO0pj5XaDz9g3ljq293tZP6E=;
        b=g6zPej6pp4+0ZmoGblh2fOAP0M7W+5oZi3BgATj9e/B1txUhz7nHdh032DJQK3V9eM
         zWSru1RzryG1HLEt8Ay/nwMVNIxhdZI3R7AfQwkfPlrRX3Rr7a2yLFpYpO+rb7Ep0ANp
         IWjWnvfBSO1CYgUs60Fxm6DMPRKuKQgKMidRzG7EGSig+6qhuJ3E4fEBeR3bg/b2zvTZ
         +XWF0Io+ywc6PLDybw3U1WJgj5GyPaPHjShDkDUYyRgOg3ygF6BvG5uB/z0t28HO/g9j
         F50cuFQKBxM388S+ChEoeQZJz6Axj0P14EJRt8ZMCxy4lIb8GKKSOSmQ3ByyGQhS5R1B
         MHtA==
X-Forwarded-Encrypted: i=1; AJvYcCX03flvMTeh42aoZbDug9SPFzH8diUk2uU1Iz/6moKDOEiG6ktB7+RIPK8Z9mL+DYjd1NqKzhLmZWfoc2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncaEqt/3aCa9KkOCy7QisMb377HA5kMtk54lvqczapu+qCEb3
	dG8mMzvtjwD/fSQ60GHKDsyq+sjk8KEP2GCF3mH6SbC27EtTsjgM2G6k
X-Gm-Gg: ASbGncuCwFqYLdTnStrKGmL/bu0AliSD5c6gf+CHhBhXptdKrMfowkJEvlBbC0bckCL
	r3xqKu93s6IiuPWgMgVhI2f2qAizxFw2YCAPv8dIdEQfnB5ktcccvVbG0M43JuckDVy9+LXxqyG
	6iu61uXgddHKSvcQBPrgclkJe6kP8QY6CEjwSNvN3UbH40zgSIgcECWb6ouk+/4BWYqq+IYcqO3
	wgOQftKdyouchcQR4G6U2JTjH9R80DA7Eg6sQvE4kJHlrquRKkcOUiRmdL6pWKaM534DYi+Dn+c
	66SI12NvfWYJHNHKBPEU4Nbs7wuCKaVToHD1OPHHQR6pN5SCMalP9a3trE0N0kszcwG3cIIhpS+
	d6wdTx3xfukm5WcjLb1zTLCEfMyy31f2Ek/KfuBUjG993PcGlYw9yqcLS2ooQObxuSyi79dtGXT
	M=
X-Google-Smtp-Source: AGHT+IFLyrEn2NNfwuX+4H10AZyrE9XXLLaNbHn0WADHyQZkZ97vhyrJ2SNn5+K0eA8x+o2bzMhaEw==
X-Received: by 2002:a5d:5887:0:b0:3b7:8c98:2f4c with SMTP id ffacd0b85a97d-3b8f4916c5fmr4840305f8f.33.1754552955310;
        Thu, 07 Aug 2025 00:49:15 -0700 (PDT)
Received: from localhost.localdomain (2-229-167-183.ip197.fastwebnet.it. [2.229.167.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm27054362f8f.49.2025.08.07.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:49:14 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ad799x: reference voltage capability
Date: Thu,  7 Aug 2025 09:48:48 +0200
Message-ID: <20250807074850.130831-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
in order to add the capability of the chip to have an
external reference voltage into the chip_info struct.
And so avoid ugly conditional checks on the chip id.

In addition the AD7994 is marked to have the external
reference voltage as well.

Changes in v2 compared to v1 [1]:
* remove has_vref from the chips that do not support it,
  rely on the default false value
* remove useless message "Supplied reference not supported"
  shown for all the chips with has_vref = false
* refactor check on regulator being err or zero
* add external reference to ad7994 as oneliner

[1] https://lore.kernel.org/linux-iio/20250806090158.117628-1-stefano.manni@gmail.com/

Stefano Manni (2):
  iio: adc: ad799x: add reference voltage capability to chip_info
  iio: adc: ad799x: add reference voltage to ad7994

 drivers/iio/adc/ad799x.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

-- 
2.48.1


