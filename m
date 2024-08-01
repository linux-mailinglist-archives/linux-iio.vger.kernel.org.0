Return-Path: <linux-iio+bounces-8123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655F94443B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11741F233F3
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED5170A21;
	Thu,  1 Aug 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRHzgeQP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB315748E;
	Thu,  1 Aug 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492839; cv=none; b=kM/VKxq/rnMIqWOFK0cLaV73Tsd37EpbVB+OOijlqF77zNECE1P7g2Qx4EPer7phKNVyLvN0mgH0A+h8yOrVBE5rfhQdyZYUXyMGOWL6XCzSQC3zzbTScTRMgfHFCCv44l6S9N7DNWMB42YpHDzi1/lRjrpp8hsP8utmbB4suvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492839; c=relaxed/simple;
	bh=fc+eWoT+LUWW3yjjk7EjbxBRAISO588WL1qR/MTsMzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L4YwikOjDRzfiNVU7+dx4UCbSW6Ndlv+0qhyvivo96W8lURvmw7msQI/IsRp4tkl4Jjs9S3FX4QP6+21/JFV/qsu5Pd1RoeP6ePsqaWq+ig6cQ7DBdYRd4c5E84j7mJ4uxuJmkrInKKQ/V5WpKe7gU1OhP7HwkPD6jv7thb4/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRHzgeQP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3685b9c8998so2839067f8f.0;
        Wed, 31 Jul 2024 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722492835; x=1723097635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LpZoniC9aGWhhQPl4KxSQTXk6eBLt8rUCgY1jOlHdxc=;
        b=fRHzgeQPJnkCqX4CIZRa/059PQ+nld1Iy59xGdWkV6pcc71svpeNnqHAhENyJcJ7+e
         946vVqY4BUer0DbBNCRekbUb1hrEUCaG1LAV12OB/CpJbSqUwQov+3XaHtpcgreusZZy
         9ce2iCQS1P+IJLHOBcmaj94KWp+VItEhs5OogVLgJcBZWbYiVsKa9dLCkzX4NhNP6RbH
         8LwaGf56ROaNGThlPbZYTkLdTlFnBooPCsLTjvbl2yRn7ENRj34U8yehPDgSZNZR+9cb
         6GaWg/wWmuKdaT/JdPD29yxyyBSBEJ4ykyaxz1MeCCPEhp8pf7XNOLE2WL2rQ4+Umf7T
         IzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492835; x=1723097635;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpZoniC9aGWhhQPl4KxSQTXk6eBLt8rUCgY1jOlHdxc=;
        b=AhmbH6giBGKSDJJOJu/QdOWu+LgKTH3iRA/jyFO3HwWrvdFB0RJeFh/Q6x9iCKcs33
         idBLJ7yCA+DKp8rJqzNXmvOKTggDKQIkFXc7QE12nBmLTXeKZULy9wWpnZwb3U3Daoex
         5KDPlQdpdXnhpx0NGu9M8pGcyllO3wNridZdbmgUX23iRNkfEEYIqBu/CHsftjMnf6Xy
         xdGhQgLmNxIFEP3tiXhgAfS/YrJtRE2ffLzzJcK5Ej3MdJUI6w16IFsKhl27/JF3JkmH
         noPhppYXI/IkJ+mG350Edsks8M95/Mnj+qzkZYwvEBDJcWmG312LaDtBcXCoGQU/4yEY
         xkVA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4mFwvVasoKVdC9KvtZokljxlNlhsAh2bRczEMDBNNnxWgEOTaT9AMBuhqPIPLCAAmpJL+SFmGSuJLevbWKiPl+wOjWaLBDOElIFBU+4NSc9K7X0lR1CX0ZEChmDqh3asvRo/cpAElHbj8w+E9jeuZVyUDzSnYVV5WWKQp40m51ZdFw==
X-Gm-Message-State: AOJu0YyJ7dzomJbJIza5SeRpJWHO4WWzUnGr6TyX2AXOe+HNkFmdD9v3
	duPJKTwqtQgem8I4/cSqWLZePf2IHzN0gmt8PNDxisgeQIcCr+qZPU4ihu3g
X-Google-Smtp-Source: AGHT+IHgSigxKibSRNszBbncxsrZsGIOUSoFP5nNFj8lRYB/6WsJHEPiu7TN3luJz3urFUbqPz4jtw==
X-Received: by 2002:a5d:5c87:0:b0:36b:b2a1:ef8f with SMTP id ffacd0b85a97d-36bb2a1f24cmr284611f8f.12.1722492835171;
        Wed, 31 Jul 2024 23:13:55 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm18696455f8f.12.2024.07.31.23.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:13:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] use device_for_each_child_node_scoped to access device
 child nodes
Date: Thu, 01 Aug 2024 08:13:49 +0200
Message-Id: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0nq2YC/x2MQQqAIBAAvxJ7TjCzor4SIbJutRAWLkQg/T3pO
 DAzGYQSk8BUZUh0s/AZCzR1Bbj7uJHiUBiMNlYPplOhSEgOdz6Ci2cg5xFJRFlrurYdG+37FUp
 +JVr5+dfz8r4f/WQ0TmoAAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722492833; l=1920;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fc+eWoT+LUWW3yjjk7EjbxBRAISO588WL1qR/MTsMzI=;
 b=Elzh0dkw5RRQVgd+a4xxoB5RdMJIejjHBeacEjAt9fRiG3ZGwzqHow7y2Mr/pozrvCL+CbSsp
 /OCLRePI0XKAPZ/Antaq4FNguQIRjb+DUFeBg3Bky5MJZH1jkHyL4fz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes accesses to the device `fwnode` to iterate over its
own child nodes. Using the `device_for_each_child_node` macro provides
direct access to the device child nodes, and given that in all cases
they are only required within the loop, the scoped variant of the macro
can be used.

It has been stated in previous discussions [1] that `device_for_each_*`
should be used to access device child nodes, removing the need to access
its internal fwnode, and restricting `fwnode_for_each_*` to traversing
subnodes when required.

Note that `device_for_each_*` implies availability, which means that
after this conversion, unavailable nodes will not be accessible within
the loop. The affected drivers does not seem to have any reason to
iterate over unavailable nodes, though. But if someone has a case where
the affected drivers might require accessing unavailable nodes, please
let me know.

Link: https://lore.kernel.org/linux-hwmon/cffb5885-3cbc-480c-ab6d-4a442d1afb8a@gmail.com/ [1]
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      coresight: cti: use device_* to iterate over device child nodes
      iio: adc: ad7768-1: use device_* to iterate over device child nodes
      iio: adc: xilinx-ams: use device_* to iterate over device child nodes
      leds: as3645a: use device_* to iterate over device child nodes

 drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
 drivers/iio/adc/ad7768-1.c                           |  5 +----
 drivers/iio/adc/xilinx-ams.c                         |  7 ++-----
 drivers/leds/flash/leds-as3645a.c                    |  8 +++-----
 4 files changed, 9 insertions(+), 21 deletions(-)
---
base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
change-id: 20240725-device_child_node_access-442533910a6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


