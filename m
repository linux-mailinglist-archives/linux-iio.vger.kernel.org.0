Return-Path: <linux-iio+bounces-13429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D69F17E5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18EC7A0714
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56286191F98;
	Fri, 13 Dec 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1nkl5eg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719981DA5F;
	Fri, 13 Dec 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124761; cv=none; b=m6gIjrWX5PZLNUxGXzgrstWh97Koxt+1SnfGov9xXmnXIw/Rnrgazpg40Y7Jk036z/F3dYMq/+jI0xNhpLVattyiklHgRBpytvI3lDBnnBFQx/UQUB4cp2whkEc5xjEH8JyHaYob4ke7ZktZo0wO5PBOvqUmY1/bD1YVud5py5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124761; c=relaxed/simple;
	bh=AMU+xgGi5tQu4UvmETK3LomT7orHOYwjYgArbLBf6R4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePXYRiXY4bSMWILCQ+8cbeNcv01VI2Rrj1Cw7FG6hnp2W0iHais1dVOHp58goYBeueAjS/rn4FaOJmIQbIsiOvf4BKPjyU27CMjQeK2DJPFl3CQ3K9g8T9T0Vsx0WFzoQy1FujsCXaFOVOQ6C615EVYiylCeyFfBBzeYV/ly9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1nkl5eg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f09be37so2494615e9.1;
        Fri, 13 Dec 2024 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124758; x=1734729558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isG6MCrgIvZst7JIfsv1n5DTVNKtFpxyTFev+QQ+koQ=;
        b=E1nkl5eg22pj25K5nQS2cPxtNHHafjdvGIHGmsMMaQaAHyQNmaqs81piZJYH5c2Qr+
         0ZbWVPhq5ChLv+nh9bit1vSX3UzD/SeTPR+yduVNf7xp7bY47lp7PslGspC3A5twFywH
         VpGAPhhDiZe3OLRZLfepjdbmHBSx1CEft0uGtZnFWDQykefsW3eN+FnnOzO7attRtWJ9
         1zrZOnaSJt4IKY5uk6/RqP6eDTSGOxfRr7QIdGScuq/2RkzViusGdhBnjawuh5wIXGUv
         ZjBklJ42H+Cf3UIXIPkWauEDvIGtInZKEfCOFa6Bi2J7FthirtI/hpSlzS7DaSl/FVB/
         MXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124758; x=1734729558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isG6MCrgIvZst7JIfsv1n5DTVNKtFpxyTFev+QQ+koQ=;
        b=FQk8LXTSxA3hnm5IXewEs43YhhdNILFPFqalJPcRPv/Ukgj8tOTD/zgnceaUNQGPuH
         a4iXKuulerDb4grYfQXYIGYa6bZW3Z6xbAPmpqNLm4ZpH3WqEGT357oQCFN3wITmPfJZ
         UsoF2KKNf5O8qJvgA5BrCQ15ixlBN0KxTLu8j1WlBhw5ElWUbTdlbvJ5HZrb6HP0U85T
         TiTXdfkivWr3+aAAk/S9sjLnSaWP8DgwyymCZK6veDb3Z3qVt7ulDRZbT9QFNqDbWafy
         tk5v9Qqam+qPA+Jw6DiPmutt7h5ioq6RlBiA8F6Kpng96mKuHH2woNF1NfrNYAf4L9N4
         JEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7NUyVqKOuxZs61mFwPKbyv9/U/ShOz/JvxQjhSJEYp8HRJzpH+/RV1DFuWbh8q1Yt+E/BJ+arwDZ4Pptc@vger.kernel.org, AJvYcCXZbkGIjF8NS3Urr3NqQtyew3DSrvse3JRHCD8EzcsN6np3IqOIxnKcRQ6HgBwwKHBG/+9rs/Ep12s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9sPk92pcxptI/C2QEl0t5eHYuARIpC3nH3Asf86AcZQlUxgV
	6s5As/extIDxJjhrtq7WUqIldKnavRfvHLWvo95iqIefn2twgrrV
X-Gm-Gg: ASbGncsv9MaXbQe7Lb6Mgd71gjQDpkn8sX/wNLsjwLD85REB3LDrY/nFJtvsMAlhsXH
	bedkkTOIJJU6V0XqF3oN3gT0G1vlURPDtus91kuXWgciCSDAcRkjTrNr9B/4PTaa+htiY58UdPv
	n1bnvn6UhP5j6W2F6qfsqfiFDovl9F3JNZWTp6cSJ6EoFq/3LSJFTUEttdKS0kkYIRHgL8lZqdQ
	5Mm5gq8KFFm247RvMYeLNNpGzyQWfKXBpfc3nDZzX/xRGUHr9GjSwGYY1HJzQgJ2rbKj4UJDpEf
	ukoWD6QlpI0YuAbuOjOXnsMwHyUvwiuxbGI=
X-Google-Smtp-Source: AGHT+IHt5eYIaRVQ+pzqfKmnrIopl0VsnDq4UA2PQBy+I/rxm/i15ljgX0yWBfsaPiVnrlxPIhIxaA==
X-Received: by 2002:a05:600c:3552:b0:434:f335:85c with SMTP id 5b1f17b1804b1-4362aaaab94mr12988355e9.6.1734124757434;
        Fri, 13 Dec 2024 13:19:17 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:17 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 0/7] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Fri, 13 Dec 2024 21:19:02 +0000
Message-Id: <20241213211909.40896-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adxl345 sensor offers several features. Most of them are based on
using the hardware FIFO and reacting on events coming in on an interrupt
line. Add access to configure and read out the FIFO, handling of interrupts
and configuration and application of the watermark feature on that FIFO.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v6 -> v7:
- reorder dt-binding patches
- extracted FIFO specific from constants list
- reorder constants list in header patch to the end
- verify watermark input is within valid range
v5 -> v6:
- dropped justify patch, since unnecessary change to format mask
- added separate dt-bindings patch to remove required interrupts property
- merged FIFO watermark patches
- reworked bitfield handling
- group irq setup in probe()
- several type fixes by smatch and tools
v4 -> v5:
- fix dt-binding for enum array of INT1 and INT2
v3 -> v4:
- fix dt-binding indention 
v2 -> v3:
- reorganize commits, merge the watermark handling
- INT lines are defined by binding
- kfifo is prepared by devm_iio_kfifo_buffer_setup()
- event handler is registered w/ devm_request_threaded_irq()
v1 -> v2:
Fix comments according to Documentation/doc-guide/kernel-doc.rst
and missing static declaration of function.
---

Lothar Rubusch (7):
  iio: accel: adxl345: add function to switch measuring mode
  dt-bindings: iio: accel: adxl345: make interrupts not a required
    property
  dt-bindings: iio: accel: adxl345: add interrupt-names
  iio: accel: adxl345: introduce interrupt handling
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: add FIFO with watermark events
  iio: accel: adxl345: complete the list of defines

 .../bindings/iio/accel/adi,adxl345.yaml       |  11 +-
 drivers/iio/accel/adxl345.h                   |  85 +++-
 drivers/iio/accel/adxl345_core.c              | 377 +++++++++++++++++-
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 450 insertions(+), 32 deletions(-)

-- 
2.39.5


