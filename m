Return-Path: <linux-iio+bounces-8407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA594E22B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04141C20B4D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965D1514DC;
	Sun, 11 Aug 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1rdIBZH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F617F6;
	Sun, 11 Aug 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392733; cv=none; b=fd8LccPAuTjUlI8MK5YjdvmAZWy+EJZRqssk6iWTPCBBmOPzCpNwLWCZ+q5xpUEyToF9WpS7/ORWYdI/geFuGBUSjuCnNMVwL6IZROxZuleh7knfuLFRQ9r0o4Nsn5BFUWwYAPF14YVyq24J4ocoVlrWmNR5M7m5UU3KNYBjxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392733; c=relaxed/simple;
	bh=ds+dCgt2y41Hw8T4KZ23X195yACAgpG0BR0/P4EsUSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCBodw7IpFOnZyuiEyF7HgCNZME8APDXUhrAQshArzNNSQhhwFhwY8PJhArRjuyyuPTODsYDBE+Jf7tS1RoUGcNMlg1D+3AAz0szHbr9kUWvgQ5p8mY3z4dZWelnt4V/y7p2p1kDhqy0MNtPpyI95683DK/wEtGcWqYxEh18USY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1rdIBZH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a8caef11fso404196166b.0;
        Sun, 11 Aug 2024 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723392730; x=1723997530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7B5/IiOOUT98QP0UKQpVXVyRn6orC2ao73q1/D+vWQw=;
        b=Q1rdIBZHq7gInzoWt35jTt8Hbc8oZEwMkDe13trfJm/susW/zY+c8rk4lRhpeMLeTW
         l/uEB2rQH8HhV5Vw/f/m1NiReYLb23XmvAA2ltuUuWQSz9+r5lZ2AySrs9JuH3Bui1Zd
         uueYWIQ7CG3FuOwIEKLvM+4gp0Hrw5gF0FZl/9hZtDeBXOGT3r1jAA4MSAZmFwNo/lRL
         5cOG0mooboK40T/dIrnSPf6064G7MEaqoSdkE7MxUd0q/yRb6XJOeGUOukHCCFpl8U/u
         kmaMvUMCfYd945RuTGnBWH6KD8sJTfv5783Sv0K3aagScXPGcaBar4Xe1dfqDEzZ/Wv7
         eSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723392730; x=1723997530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B5/IiOOUT98QP0UKQpVXVyRn6orC2ao73q1/D+vWQw=;
        b=CTspHVnAW7g9Xs4go6MY5QEFWov8hI4UmDrJWvPoVRfIjyXb4aCrAp0fgv6SWm+NKD
         z6mN+eXozrEBzxlUFufrRmCnUdeRxuNgNtw7u4VRQZT0KNoXlcE3PepTvP85mhv3y4fb
         nWRFw3NQbv0CyVtlNwynt7LAQ/n82jrY8p37lb6EvmJha3OeQ00n1twunTZ5cBleN494
         LUSvT8JtaoOfp512IxQFE7xIbYQL9cw04xMsy1nW+YW/FfERZ5i4Fx4ng5zk55hS3K/i
         2bbfygXU+9MxXUtb37GJja9hOhd/jqbos00O0BCZb9Z3nD779PhQK84klQ3YQhMGJ8jJ
         /DPw==
X-Forwarded-Encrypted: i=1; AJvYcCXH6cjX5ODnqZQusrROxK6dI2JdljW3KhOo/hM2gvES44pyngqOc7a0PYQ6+Dni6ISR3phlfaWw7OkIWLgHecWz/VDxI1J8oUU2dC9suss9TAHnBDu5eeavABFo9JPY0fSNy2AkaO71
X-Gm-Message-State: AOJu0YzpA8fEnXrnnBTLh7NUEkzbKoF2E0k0o8GBnLhb7f8eJ42qsoYp
	EcJ+6rMD62NVgIEsx324iyrvWL0e5eeFbLueVumumkjhGuuX1P/I
X-Google-Smtp-Source: AGHT+IF2lPVqyOCrxJfF8Xe6T/57bLyRz03xixtumy5z30eoyoYsq+idBY4wmzilyBvLvYB8nk88Cg==
X-Received: by 2002:a17:906:daca:b0:a80:d683:4d23 with SMTP id a640c23a62f3a-a80d6834d5dmr108484566b.62.1723392729895;
        Sun, 11 Aug 2024 09:12:09 -0700 (PDT)
Received: from localhost.localdomain ([151.49.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cd337sm158535566b.142.2024.08.11.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:12:09 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH 0/1] iio: bmi323: have the peripheral consume less power
Date: Sun, 11 Aug 2024 18:12:01 +0200
Message-ID: <20240811161202.19818-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi323 chip is part of handhelds PCs that are run on battery.

One of said PC is well-known for its short battery life, even in s2idle:
help mitigate that by putting the device in its lowest-consumption
state while the peripheral is unused.

Have runtime-pm suspend callback save used configuration registers
and runtime-pm resume callback restore saved registers to restore
the previous state.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>

Denis Benato (1):
  iio: bmi323: peripheral in lowest power state on suspend

 drivers/iio/imu/bmi323/bmi323.h      |   1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 183 ++++++++++++++++++++++++++-
 drivers/iio/imu/bmi323/bmi323_i2c.c  |   8 ++
 drivers/iio/imu/bmi323/bmi323_spi.c  |   8 ++
 4 files changed, 194 insertions(+), 6 deletions(-)

-- 
2.46.0


