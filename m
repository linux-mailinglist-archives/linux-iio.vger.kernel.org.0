Return-Path: <linux-iio+bounces-18577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F5A9982D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85219188A841
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF828F52C;
	Wed, 23 Apr 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAJj914p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE228F504
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434341; cv=none; b=fqyBjKFG7DvpCp8YR9EYa2wEuTe9NgAhvXP6KjeHa9L7KbmvdWIblB721tk0FUL+K9wz/GtpwjRfplz5Rvs3hjdZY7Ofqegz+KwEVvVcMEOghSUPcTChTxcUJwd2LXFg7ndzVdkmE/j+sH3CA/2mkc9cCNemHmkX4LiERRt8DNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434341; c=relaxed/simple;
	bh=fwuCLTLnEtJB1HggZfkKb4KaEunA2zrMNmpZyY0034A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBjbDXEu6HH6Pt6evy1sDJW43srqMFKGtx6/MXRpYuE+yk75g3JDgiB2ZNTNCp9QvBDX1v4zpzoJYzfvczQBucDihS/GofPEedVl7LE4s4ibUXW7BQKXkkzamSqqeI4nlSRNX3quJnqUBhO08loLLkcOFqkocHdYwZn42ZYQeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAJj914p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736abdac347so18230b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745434339; x=1746039139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWR7xF4jtEyznu3YbDM99RiovKjGiHK6/osztKzsFls=;
        b=FAJj914p/U7p9H+DxOFOBMQBQKPWLcup+cBm0FIONGJLa8OfpcIS3+AM4x06XSxKto
         bDDm9iWoFd1sqqpeh/6jawnlQE58BuSCX0z+yt3WS/eKPXYZmSJSJFjgSPboHePLq28Z
         tByv9N3G47Fl9OvWPqTSiRgIrwDUmDD8sSzPjhbtJC1UR+mQm5BLdgfZZCMioOM5WmuY
         gPeCXtmuMAUKPpNk4HfZal0QG0fd5Q23O2KV0qS7u8Ky4OOMGMgEAyPdmkoLU0NHj6+1
         sKdU+acROSiipt9h00R8/Mr6WcFBn7MIQRwAQ0KOoyEEV4MyuasQV56dQoBv5y2VLiB1
         CkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434339; x=1746039139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWR7xF4jtEyznu3YbDM99RiovKjGiHK6/osztKzsFls=;
        b=qU2LMSkdVZdcN/Ncr8MAK0zbq6QOeFiaXjVL0qe3GHgFq/5RANidebgz64inq67E45
         DF4TPKjNT3SSTWQIxK5qj+u9bx6OB8GmlyWzY/ew3lmnjWGbeHTFmNd5u8hzwppHfWyi
         DUwW+hFdWmBy5j7OHt2PMX0Mo49p1ZxROiFyyIwTuTeBamD2hv2gr2h2buVtmcrB9gpj
         LrJONgKs+QoQfmR5umjBhxnGEUewTI22BAEM1IhhYTaj60kH4D3Fb/sXhoWA9p7fpWdA
         5IDMigCR1RgnEaIEYcBOu4dt1VXwVfcnrzMNDzTiuL3+yFcWA7cB2+UE85fXb8vfXW2u
         QmqQ==
X-Gm-Message-State: AOJu0YxsoY0jX9KsB8nw/rz5AIXsEuqBC3eOfv3EZyESidk9Mt+0EJyS
	ZmfgAE5eiCc5Zohfxy1Xny7WZpYH/c4QyapySyklek/uNl0f+IOjr+vZT6hgyos=
X-Gm-Gg: ASbGncvqWFyXy0ZLgoI3GlaV5eypvvEqtA8hA8h3gq3bJPBrf95SHQJGqSXz/RGS+Id
	NjlugOZ0L84MHWv1i7ncwQcf/DTq7G0S5tWricG38Qnjxx/XOw/8+lAVtqGYfzKW1xwyGgdYFyy
	bVVygqAsuOVt7C/NrUiq+RNES4ylTZFWnjc6T9aPwl7/pfzYFrgOnctarV+DwDkJLZ5VBYo8Ldk
	qqHbXXf5j7+P4th0HZYezg6um+grU8JuCGqHOOAzA1CJXyLFSqEdhNMEH//kZCY9FnJvxZsbzVQ
	vSEoHPGgRj1lMwQ4g7YQr1a25tSJyZJIupPONz2GqpHkwDSlfiw7qKp1qq33+3G/6myIAQ==
X-Google-Smtp-Source: AGHT+IFG6D7m7U/9ZgOyZRt0eMq7IfnxBS01zUsLZsIMxLHy33jBI/fvDjy9VuqcCJ69bdABJt/qAQ==
X-Received: by 2002:a05:6a21:3943:b0:1ee:d5fb:dff1 with SMTP id adf61e73a8af0-2042df0c519mr2293444637.8.1745434338589;
        Wed, 23 Apr 2025 11:52:18 -0700 (PDT)
Received: from arthur.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa588d4sm11343294b3a.96.2025.04.23.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:52:18 -0700 (PDT)
From: Arthur-Prince <r2.arthur.prince@gmail.com>
To: linux-iio@vger.kernel.org,
	arthur.prince@ime.usp.br
Cc: =?UTF-8?q?Mariana=20Val=C3=A9rio?= <mariana.valerio2@hotmail.com>
Subject: [PATCH 2/2] iio: adc: Kconfig: add kfifo dependency to fix module build
Date: Wed, 23 Apr 2025 15:46:26 -0300
Message-ID: <20250423185208.752080-3-r2.arthur.prince@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
References: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add dependency to Kconfig’s ti-ads1298 because compiling it as a module
failed with an undefined kfifo symbol. Building the full kernel passed
since kfifo was enabled globally. Selecting IIO_KFIFO_BUFFER in 
ti-ads1298’s Kconfig, as done by other IIO ADC drivers, now ensures kfifo
buffer support is included for module builds.

Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..513f2238fdee 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1492,6 +1492,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
-- 
2.45.2


