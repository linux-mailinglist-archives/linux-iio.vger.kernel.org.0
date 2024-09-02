Return-Path: <linux-iio+bounces-9001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53286968840
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10B21F230EB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9091C36;
	Mon,  2 Sep 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz6nS4Pz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2A19E960;
	Mon,  2 Sep 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282096; cv=none; b=DIOPLorTJN2w8Rq/pAU8KFOmsgU8DliOafAQXdFEx492Z49mOZIvPr6cMoqfoKCq/dipv92K7SH7QnMzvHmEH9ErU4AA9TB6JWC+59MVNGWEK6D+COcmVzR7GE6aoUZta5B1Wbweyih7kr2w5VIIP3HLjFReHNkCWB38z9qabDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282096; c=relaxed/simple;
	bh=DujfxkayoMPJPyhvEgduWI1JdC4jCdW6C9xHW0Ikpik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i0NYWuWtoLwqWVUbJR2/8utB0FDwxapjXXu70JkJ1JzwY7hmqMTjl59bDrIm2zDb9NLyryLX/bTIkEhx4VRxxmnjBUXt/ocs2+Uz5XNpAMjzXGnWyIsba2HWDASmb277S0g9XuFwcm6BLOKYDo5DC1lofXk8KI79y4K3Pit+/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz6nS4Pz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so495547566b.1;
        Mon, 02 Sep 2024 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725282093; x=1725886893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0x7mltKPnjAI77jOLkK3h2Z4ZwMQgtf8YLIOVS2vHA=;
        b=lz6nS4Pzc63VboVl9VDvrIEzNX1EyeHcfV9LCgG5zKgdgJbqedR8dlaTbBRrV+Alzr
         C0QTEl5FaVRmlTMAZTo+fnYG5Mt7cMq0TqVKLWL2/pZ4S7aEROU8HvTA7Tc2z+HIqj2g
         yDKGIgxNqlOXhiAoVWGew5i/aVri4Ru85HjcSVz9DGHkdPTQC87Vo3KkOuOe9pmmNarN
         GF2JL21JrI4HcJbFMGDEgtgHspGvVY206j1Q0amdu8Sv8he5273PpJWOzPyaQGb9/EDU
         6NsDkuVoH+DzQlORMvO6YQDBHOilp07CFOqe/SJ+8wf22fszKPYRAjR82/xXaQVUh6IU
         C2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282093; x=1725886893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0x7mltKPnjAI77jOLkK3h2Z4ZwMQgtf8YLIOVS2vHA=;
        b=YEAeU8xUbyD1R/1/kgScHoWlHaSFr4LPmVb2CeqE48o1YCUwNXQR5StnH3fB5H2pHg
         soG0iJABgzjWE6XqFO1x2AVSAuqhvJDRCw28xdh0r0o0PZuMKLTP8kgqQJtcUY0+1IIK
         I0VsEVMZke7jjAX7dKDarasCk2A1DF3wUu3Cqwe6DbdFnn+J7EHaMT6N6oj+iIpt10ol
         wzrhbUlcF5hJLcZ7Bhq8DqrkyVRxAH4TO/FcDMk+cxce9P5RB0qD/IvQ6SLzhKtvMyQq
         l+HnEgEB/IGsR/tIBWCNmzoMgm2j5+WOtKZ30WkUVdy2lPIMdg09nchTs97sJL4jKCg+
         mIVg==
X-Forwarded-Encrypted: i=1; AJvYcCU3qGbbsHJoJuQ4TbUbUH7Z3TYGly1yzFekbQo5RQvOValG6h1yU2ADQGpQ/Le5qjNdWJqh1Yc1GR8jiAbW@vger.kernel.org, AJvYcCVeXTgIxpnVO8SMzL4HUIGPFTiugcyPxaKRPLLihM2QwIcFQYlSvGPP3LTahyW/if1AknVBEuMaI95O@vger.kernel.org, AJvYcCWM/pqsZQGN9Gxz7AuDSBmAeYq/3Tt5g9uciURZXIPrd4he+7eVXPhtsK+Q4SyEfRGY7GC0lqV9ARMn@vger.kernel.org
X-Gm-Message-State: AOJu0YzguO9+9Hzr2cJWQ6F9PX3BDT8JaXfU9FHeuVukykZXVNF5NDlO
	0xBoxA2ZxaDNhdWatSPPjRR9R9FedRqpVK5wmhLrM4HfEu8goleUSc66q66F8nAulA==
X-Google-Smtp-Source: AGHT+IGEdIDyITdsjTldmHRkGumWkb6Np7+1vwy6KdwTSPVtUejpAdMD7VZMFD72BqggdBhOOqlgCQ==
X-Received: by 2002:a17:907:86a7:b0:a86:843e:b3dc with SMTP id a640c23a62f3a-a897fad6fcdmr821536666b.62.1725282092054;
        Mon, 02 Sep 2024 06:01:32 -0700 (PDT)
Received: from localhost.localdomain ([37.162.182.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196968sm554979066b.139.2024.09.02.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:01:31 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/2] iio: temperature: tmp006: support for drdy irq
Date: Mon,  2 Sep 2024 14:59:45 +0200
Message-Id: <20240902125946.350635-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the data ready interrupt of tmp006
sensor. The interrupt line is pulled down once there is a measurement
available to be read. Hence, triggered buffers are used in order to
support continuous data capture for the sensor.

Antoni Pokusinski (2):
  iio: temperature: tmp006: add triggered buffer support
  dt-bindings: iio: temperature: tmp006: document interrupt

 .../bindings/iio/temperature/ti,tmp006.yaml   |   6 +
 drivers/iio/temperature/Kconfig               |   2 +
 drivers/iio/temperature/tmp006.c              | 116 ++++++++++++++++--
 3 files changed, 117 insertions(+), 7 deletions(-)

-- 
2.25.1


