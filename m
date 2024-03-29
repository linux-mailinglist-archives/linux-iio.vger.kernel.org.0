Return-Path: <linux-iio+bounces-3926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3D8924CA
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 21:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42071C216D2
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104B13B58B;
	Fri, 29 Mar 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGBkqM7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37F13AA48
	for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742712; cv=none; b=ZGkTWAn5A/vM8Vj5pE7ke2ZQcaJXmco/fXRPtxvHszRwbrZ9Fr2NnABTGVuZv1xNS89URCziThcSnB7wvt2cgMOa5z9mJSgc345Y9/OYx7bs+8Kc7ytnGdn76Dv9ZUHfIvsQX8jbScEQqdMat6twq4HtPStUF3mOYNDKOGKs3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742712; c=relaxed/simple;
	bh=cIbe2NRCQP7djfpbM+11L+WlZLa/v/ScA4ZubIQlJek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6YBEL2yEEKOus75+c+EtnC14WfCM+XieEdOKwnHodCzkIVvb5Sx4TwUu9B4POMO/xyEQHjO/NSQdSHFW8oQ++sRlgl3CwLGAL7ZgmWZ7BArbujaV/goGudXbkdklJETe5fbN3HW8E3VO461Lg09zVLchS87zCO0uvoK9RHHY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGBkqM7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SnHjQH48YnJt749mCO2kgMTpPbKk2F0bzExQRDPnK30=;
	b=jGBkqM7E1xdvT4WuSlrGo/FzGu+P323MbZBaxuPBkD6BVidOEECBc5FiSaZ3Flgs+sNivd
	WxzaOig01l+HEvsEaVA4e1SJ+4VYao/m0ZwNIBPO/1Q26hvb4igK3EHgiN/A1aOO3aw8KY
	ZRKUrOMr5/jjk2XWOe9nkCFsed9qpmc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-_vnt1uSgONikYpdA2YGSFA-1; Fri, 29 Mar 2024 16:05:05 -0400
X-MC-Unique: _vnt1uSgONikYpdA2YGSFA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ea7dfa61d8so1928081b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 13:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742705; x=1712347505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnHjQH48YnJt749mCO2kgMTpPbKk2F0bzExQRDPnK30=;
        b=U0EnbYUHr9+3Y7ayLR8ZIvJgb1UOYhQUr+mJi9egW0VEe8ZSxZWtYEhIQP73TpHQQz
         ueukmXgENBENtB+HoJ2QvWMgn5/vaO4cXfNJEwTGAyi0Gx2Cf1hUWl/KMCa7aAiZM7E8
         qeYNyAjTTX2l0jgBLXMSxrDjzmNDLKg+I9sy7kg+VUxY1hyL+rYrELsiXcr8VrFghWRA
         Emh77Agsn6k8SlCKMgAn4vtSa6/GSYUEOddqk37sG2cm/YsUYTHtYDXRZT622Yus44cE
         bSm9Cfnk4+KJ8PVuFsQrihtPe4BtDOpKpjtrphh7tbx1vdEUKV46G49fRpsOW0NLCbwT
         H+YA==
X-Forwarded-Encrypted: i=1; AJvYcCWmiYcOUXtiVjAiQfVjKixdjJuMAnixs3C05D31LvxpxKtX+MxSsSiSrUY55GM86L/KgBJU5qVd6FslFPXpAuySvfV70jmPzhLB
X-Gm-Message-State: AOJu0YySkxV0oLNFYYe3AAukabxMcAqL/Fia+a552MdbuFarf8b3ME8E
	2+52K7BpWej9gqXBz5Z6dw4CFVk9e13FjEa+FLBBP9XdcA0PAOKhTvNZSuDZT64qeE70y8Jmhf4
	3hIs+4agy2MZlGMaRQWdwn2QOsAz5t1whOJzp/In2SdS29VLxphVrzOUfEw==
X-Received: by 2002:a05:6a21:193:b0:1a3:c8d5:707a with SMTP id le19-20020a056a21019300b001a3c8d5707amr3325582pzb.7.1711742704932;
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzus5TYmyBQIJzw2X4oGKdRnzm+fHezhgpcMAHRkbhzjBiVvj5MPNNZHf4gEN4NnQQtcePCw==
X-Received: by 2002:a05:6a21:193:b0:1a3:c8d5:707a with SMTP id le19-20020a056a21019300b001a3c8d5707amr3325536pzb.7.1711742704523;
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	guoren@kernel.org,
	conor@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	marius.cristea@microchip.com,
	fr0st61te@gmail.com,
	okan.sahin@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	lee@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 0/3] iio: adc: add ADC driver for XuanTie TH1520 SoC
Date: Sat, 30 Mar 2024 04:01:23 +0800
Message-ID: <20240329200241.4122000-1-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

This patchset adds initial support for XuanTie TH1520 ADC driver.
This is modified from XuanTie TH1520 Linux_SDK_V1.4.2(linux v5.10.113)
The original author is Fugang Duan <duanfugang.dfg@linux.alibaba.com>

Wei Fu (3):
  drivers/iio/adc: Add XuanTie TH1520 ADC driver
  riscv: dts: thead: Add XuanTie TH1520 ADC device node
  dt-bindings: adc: Document XuanTie TH1520 ADC

 .../bindings/iio/adc/thead,th1520.yaml        |  52 ++
 arch/riscv/boot/dts/thead/th1520.dtsi         |  10 +
 drivers/iio/adc/Kconfig                       |  13 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/xuantie-th1520-adc.c          | 572 ++++++++++++++++++
 drivers/iio/adc/xuantie-th1520-adc.h          | 193 ++++++
 6 files changed, 841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
 create mode 100644 drivers/iio/adc/xuantie-th1520-adc.c
 create mode 100644 drivers/iio/adc/xuantie-th1520-adc.h

-- 
2.44.0


