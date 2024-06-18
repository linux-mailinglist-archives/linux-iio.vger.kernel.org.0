Return-Path: <linux-iio+bounces-6501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD490D56C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493228741F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C515D5C8;
	Tue, 18 Jun 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEjMXxf8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABA15D5B3;
	Tue, 18 Jun 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720518; cv=none; b=sWs/8mEaTWFOJIuxjfuF3m/if4/Rgs/EHyDs0h5Gk4dkBzGRKiYI4CgmLYuyg71JrU5DceyifgUe+9xX+kXUFrddY1oRESrq1R06ad8teUX9mmktzyPBo7y2JSn1merFIidiOwp5gdRrU8QYulL8Dx7WXMXYz+NwNzxC8gck2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720518; c=relaxed/simple;
	bh=7lEOia7yNMJxTHojUc8gtsiIip9Kw7zm3aXNf+Yu6+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIR1Nv0ntztfM5HBPxqj1O2azCV/P3iLLERAJc3NOvdv9E+sEXXtqU9inxLIfG18Th0c26vaGSxUXApsdxLvU4c9jYIxDmWXaYIQwm8LZkhSZ67/QYln9gXjcgMtzzH/PqNRVkzzsMTt8lw8LJ2agFsVqU/mu3eUBeV1xT+iuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEjMXxf8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a63359aaacaso860814466b.1;
        Tue, 18 Jun 2024 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720515; x=1719325315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq4PQhizNWKZmJhazZTyh1bt6bLuXIlAMa345ygSFKs=;
        b=lEjMXxf8oYOoaV5IV4EsNhv7YDgVZ7g0b7fpecKwECSLiW88tvEyG2/ENRqdiITJvl
         e6qcYZTviFQRQVG+OlO4bb02rhkxDqZ4huyXlRzaZ7BaYzR5nsEHi7jOq4eNqptNkxPW
         FNNAtdn5rBhbtwIoOBIzzSf6NQJscVopIkSkqwMuw2tnK5rd4ul6YzMbeUer4i5w1BzE
         UETcpvqPsnaquQnIFsmACBHGho1OOSxUnvnkibqvH7+U27tx9VjKDFIU2z71M1UFhMoS
         Li+FEoy6L/oIpY2k2MTp13nYPkmHcYQ6FOUy2IjezyfeOonAn9/eZ3JPJDHMvTDzB3eZ
         QWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720515; x=1719325315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq4PQhizNWKZmJhazZTyh1bt6bLuXIlAMa345ygSFKs=;
        b=Vi3JgHh8tLYwfhwpik5VJjd4d9iL4OiFpHetyEkzbpWphHaFyCs79SJUKAq+JaMQs9
         UEAH6MFpOf9jsU9gnTpmULKtYSYvIp49eE+m2WFz778wdH7zUgmI/SBjIYyGMIb46EV4
         fYuhdA+dqM1SCpd8MRe1AKLfpqhE9EQjFLpjaqaBAatsDz8rNp/SfBKvCBTD2FlIBxb8
         eeFSCMtCohFWYsuNTSjf42y/8YVoYt1Zz67DIYidSjsjzT27l8mbUXtkvybSd3qwsOg5
         v5RP0GnTZm+1yqI3OvcdTt9fi1evhWUW7p4+u+GnxMH6lGmLy6+aAhkE9GffdW1P1VhH
         06BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8N5Epnyw53EbZmLeJFbNaPzeLE79aK4LjkTpiWf9Wk7eDrXPHJ0c2K6JnzsFjlRIqerXfcc5biEVpEHdz3odSFx0QXPj+NF57UlX7tPaxeHFdnXEj/sB+mZX+x1Wky98TxBjwRPc4HrvU/QQPsFUWmghyYUqoA7hvjPioyvhxwoOxA==
X-Gm-Message-State: AOJu0Yx5wOSut0v7pokr3VL6UmLVxvGOhCsovLdryWetM9G21cpUzy8A
	OgK14mqPzB9dPRutDX7qtQYy2ZEy1+Cnk3mo2S7GjcbhhPkEN4WJ
X-Google-Smtp-Source: AGHT+IG3Z0H7JdFI1oTj+9mkzib5XlNK1J//kM/ij8EJsu2O4pAUJSCVwm0lIyz0ShwKNrfUEX1ypw==
X-Received: by 2002:a17:906:1c45:b0:a6f:1ff4:c7d2 with SMTP id a640c23a62f3a-a6f60d29673mr862846166b.20.1718720515030;
        Tue, 18 Jun 2024 07:21:55 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:21:54 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/6] iio: adc: ad7192: Improvements
Date: Tue, 18 Jun 2024 17:21:32 +0300
Message-Id: <20240618142138.520192-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear everyone,

Thank you very much for your feedback!

The series is based on testing branch, since the initial first commit
was applied there.

Here is the upgraded series. Please consider applying the commits in
order!

Kind regards,
Alisa-Dariana Roman.

v4 -> v5
  remove already applied commit
  modify commit message to mention the register configuration
  remove useless | from bindings
  add removed example, but still remove it in a later patch to showcase
new functionality
  remove clock-output-names since ad719x have only one clock
  new patch to replace old maintainer (i mistakenly sent it only to
linux-kernel mail at first)

v4: https://lore.kernel.org/all/20240613114001.270233-1-alisa.roman@analog.com/



