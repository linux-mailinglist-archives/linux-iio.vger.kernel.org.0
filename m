Return-Path: <linux-iio+bounces-6242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07079076DA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DB2872D6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848B12DDA7;
	Thu, 13 Jun 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="TMIU3HqX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927112D762
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293185; cv=none; b=CBRPwa0vGU0+EQFKX1Xo6KM6SSerrk8oSGKGna96BArbXs4bEXPWZug9sOKIcLeNlSDxti8iTeo4SEXA3p39uHK8kCIImu2UO44MBU01uz35aVk6vbXRwcUdrXhcIeOgvUBkTxdbbffgu7x4/cfWKPMtLuSz0nQ6CByhgK/gnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293185; c=relaxed/simple;
	bh=p1YDC8/ZqHKs+M3Rd8qmYfVZYKqvHnwHj2IIjcJtAUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwYqshmVmyYoGSh4ZTTdLksD2Sm6eW+MPJXVN5YCTQy6gXkn5mJPDZisOBHEiUU4DTIrdDbSDIKajLzB2V8r5TyQ4CyxQMLZ7xIf/ZzFxG3jmmwX35CKa/6270fCeUTakv6OOsOnij+hIX8sYY9C9ypOyvv6CCA5/bY9Q8Edk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=TMIU3HqX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a5344ec7so8602175ad.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1718293182; x=1718897982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iudmf1gtR/NnAF2r0MpNGeo1cLCpOPc846oVeb+i9r8=;
        b=TMIU3HqXjEUIbzFDVzdVWdTzqu7kHWk19h+zhnGPUIFyr4qPuBPai2N3A+Oe0Jyu1L
         px4aFMCiRCgxLsrwFNTUe89WfIrFCtKMZgJynmMeFFzv42E01ijiqKKtfw7PMzoFUAEb
         HeZfXhBHmZLQxozMbfvv2Tz/BjnWbkCJvuBx36fTnYYmdL5I7p3C1kcadSsTTESIWdim
         EHVNhHL/A7bmbuwCrw52cEsj4V8wC38tHp6GrJoH3y0qThJEaQw7v16QWbf+rb/fm+aE
         m1SrB6mcIr/IY3U3e6XtaEu8VTG5poo1MPnhqE2/qh0fb6TkKsBWSFJz8gRo7xXH6CR8
         h3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293182; x=1718897982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iudmf1gtR/NnAF2r0MpNGeo1cLCpOPc846oVeb+i9r8=;
        b=WpWxWW7WCaZj3py2ghp1U9dZ8WWM+xytJkqmNIjNnq0Zw5wD1CV/5My4xdWM6BBf8b
         XDRYV6IU+2MW7XzhqYotG/+AtCuz058aQg5bIJIlLnBdW8EHiyIlbbnlzFxSbDwFULp0
         e0NdpSIjGpz1xTYJdgOdFAhiUMzdcnYK/HyQfJGm2UkbJ5AOpDZnklQGmO52dlyjsUgW
         sbOinmunbjQmWM10KFAdZA8hVMQW2g48PR33juchp8GJqSzWMuIMKdGbrfOhjE46dlhS
         VT2ZUzQN17/o+bxHVjf8vmMJbvRGU02VTT/DZvxVAgd7CCEloVPCptz/E3FQu75d13Zg
         16iA==
X-Gm-Message-State: AOJu0YxIvSBexJpuY1OD/ptSZHT2G8gOuxFIzxtoD55FoIxaFJwZFj0w
	JA2ALwXE0Bu5YeDUbV7X+os5RxyGOXgglwRdvxjbA8grh3QwBc68tTn5hrEmAT7cSRMrd5CLH/R
	L5sT/Gw==
X-Google-Smtp-Source: AGHT+IFq0OTHIhB4u4r7R66pyfsdsr445AoX2Sx7V35/6kzaqB6vxhLsNsBEyWQg8jUyDsiyOMIL7w==
X-Received: by 2002:a17:903:1c2:b0:1f8:5e80:855d with SMTP id d9443c01a7336-1f85e80887dmr12846845ad.12.1718293181956;
        Thu, 13 Jun 2024 08:39:41 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55d7dsm15372295ad.14.2024.06.13.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:39:41 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: linux-iio@vger.kernel.org
Cc: Fernando Yang <hagisf@usp.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/3] iio: adc: ad7266: Use iio_device_claim_direct_scoped() and clean some codestyle error
Date: Thu, 13 Jun 2024 12:39:17 -0300
Message-Id: <20240613153920.14647-1-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checks ret variable after iio_device_release_direct_mode()
Switching _direct_mode() to the _scoped() version
Fix some codestyle errors indicated by checkpatch.pl

changelog v2 -> v3:
- Adding Fixed tag c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")

Fernando Yang (3):
  iio: adc: ad7266: Fix variable checking bug
  iio: adc: ad7266: Use iio_device_claim_direct_scoped()
  iio: adc: ad7266: Fix codestyle error

 drivers/iio/adc/ad7266.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.34.1


