Return-Path: <linux-iio+bounces-9436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2019745E4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 00:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB31C223F5
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A611ABEB3;
	Tue, 10 Sep 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbjSE0Aw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB00192B84;
	Tue, 10 Sep 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006979; cv=none; b=cFvG7TnJF79SL8AvZkTuZSN2wk5Po2bsGyz//+37paJjyTSmUipySuQRNxUMEfoQb8Pk+FtEJ47XBNJiyLFSed1q0KZbK1HonVDBuuUMqIiHgZTWBpdAxcVzWrfMynzTNTIqut0yKvAZsM9RjzDLonYa2zhF9IBKytzOuggriFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006979; c=relaxed/simple;
	bh=nWDIUhPbDOdOvxZD/AeQRWA9CuWMQJKn0QwLGuQZYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5NNoRJjLvNcCH+BfjxydTw7rDoNkIN607xTJyxFHihu6xa0izRNO/yLB1M18DDTL6J/kKH5bmaz55luAyYSocDi/6oA3w8cSQ9wn4WsIvjYjrOEzP1sUe1743Ton3o14FfK2+MziRwi10CJorMFS4s/NBM0UN+hyA6nE5Dc+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbjSE0Aw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d3e662791so218242166b.1;
        Tue, 10 Sep 2024 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006976; x=1726611776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWDIUhPbDOdOvxZD/AeQRWA9CuWMQJKn0QwLGuQZYQ8=;
        b=RbjSE0AwyJ1hU8M+7k5/0giuU6PU4LBdpFgqaqgu5D0jkM+n40oyxWSKtOR7rHdn5U
         OvIlifcXOu80BdhRJjlv7k4HZMeV9G/iOZZfmETRVCe11sDDfXPHHt0F0Svw4qiZC0B2
         YH+G1TY/FxQfOKhUp1Z9YtwGffrZj7sPdLJ91jUZFiUHa7PnBVe9n89GwBhRnC3JczZj
         UhL6gf0KWuxU8yi6QTDJoxmtjfHpVEGa8HXP9SWLFdLT8rAqpXBpItNijOD6WeSHKtcU
         Wx3w5w5XEczZBprZZiqrbXH6ZXNL78Elb3Tb5SkE5kGROSAhh8llSI1GthF6jNdz4wth
         zl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006976; x=1726611776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWDIUhPbDOdOvxZD/AeQRWA9CuWMQJKn0QwLGuQZYQ8=;
        b=WtkMDmGJVrBpXD1YBWjbkGuRfNp2dLkgf9ar7soG30G+6xSIzXVkUJB3YVKV4lS1lC
         NTCdXZJ5QYWKwo7jSY7FMvnpudgSsT/jvbP0s2cJVzBNVu5a59QU0bGaNlxF7y+6uAj8
         RXS63abh7tNx/LkDGq+yBxCHKlbxvISFcCwyAOVOW3Tirijt389JVCiooc145cNWmAnT
         CBZhuzyiUhc7QCQvaLbhssR3kzCSpY2+O/nGZ06gFJY5Sz6MKHjPQjPyfTvR4+VT36rd
         VVioERG+uATooC8NIOCDueHyrUk6bp8Njrp5Y2pfeCae5DhHh7Xx55m3YNSOKmlXXVUI
         Iz3A==
X-Forwarded-Encrypted: i=1; AJvYcCVIOLQEmQuMY6aojmn/f+8t6fBHNaSwcqfIjKn4ETVeLtoA+XTjdq59/VdH8gc6aG6wQXZwrkMOc+f4@vger.kernel.org, AJvYcCVpo+9uwJb3Ef/g887aw2UKZxyfzTZpzHHCdEwavPGd6sigyRZXDG2v1S/fVNLsgGcD6J7R0DlcKCeI@vger.kernel.org, AJvYcCW6ENBtrnjoqXbzd01I5Ppvw1+nFUglC16aYfBEazn6/SrZDybR1+KzX1nMIUgBWn2+fSZt/NO13jL1z8nu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vsmbDdQWo2GOu0RvbBTJwcpKvjcNMx9GCddlCc+qHI0Mx8zG
	3r1g77eDAZXVONYwYYSEge1pwztBsbL2zxyAutRR0ufRbMx0NYj5
X-Google-Smtp-Source: AGHT+IEOkX7gJEx6aRMFapdf8fVYvdC4mXv37XJ0mGPzipQWOlhSynFEkCFSeo764XF1s14W3huYQg==
X-Received: by 2002:a05:6402:210d:b0:5c2:5f24:98bd with SMTP id 4fb4d7f45d1cf-5c3dc78b665mr16745577a12.10.1726006976115;
        Tue, 10 Sep 2024 15:22:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467a7sm4664568a12.28.2024.09.10.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:22:55 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: lanzano.alex@gmail.com
Cc: Jonathan.Cameron@huawei.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jagathjog1996@gmail.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	ramona.bolboaca13@gmail.com,
	robh@kernel.org,
	skhan@linuxfoundation.org,
	vassilisamir@gmail.com
Subject: Re: [PATCH v3 0/2] Add I2C driver for Bosch BMI270 IMU
Date: Wed, 11 Sep 2024 00:22:54 +0200
Message-Id: <20240910222254.14281-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909043254.611589-1-lanzano.alex@gmail.com>
References: <20240909043254.611589-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex!

I recently received a review for the code for the BMP280 sensors, and I think
it applies well to you as well. Since you are using the sleeping functions in
your code, maybe a comment on top that explains why this value or where you
found it in the datasheet would be helpful.

Specifically for the Bosch Sensors, because Bosch's datasheets have either
hidden or no information at all, and you need to search for stuff in the
respective C sensor API in the Bosch GitHub.

Cheers,
Vasilis

