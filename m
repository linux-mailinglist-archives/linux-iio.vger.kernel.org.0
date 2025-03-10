Return-Path: <linux-iio+bounces-16705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3477A5A52B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81442189163F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A711DEFDC;
	Mon, 10 Mar 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="deu/J9Wa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DD17BA5
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639391; cv=none; b=MAZGxd6cXdEIZXuJnOo53VwrTc2oyp28HOO+z2jzCEHvgz7BrPyMI/FxR0pk7dCHGKuRNQUvRVrUf2Af+/VXF5mNx1nWwZ2tvDYtGbakAoj52MXZ4YzpPdNG6ioCWoODoScGkyQB/Apl+lbjyobQp2YwgvI2HHckB3y9Hzh5qvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639391; c=relaxed/simple;
	bh=3SrpO+SLfjeGySU4NOt+3eLm43DAaCmZFXhMiw2KWJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ny0zVL1By3haNJ6bxtnvs69uHaXh8w+P3HWmgCitYcA751xWPfd6dwI55cPZ5v+jOR7I/CramiwM4rlqCqyX3zsi8lb/uk/7thEfA/lb5MzjmKzrwKzj61M7Zzm9B7UkVY2aqia4DUu5nagDEKt0wZsad4YcUOGoiASkGrrUsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=deu/J9Wa; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3edbef7d2so1557942b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639388; x=1742244188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1Uwtz0E2eftoKGPgXBkETiGlWCcSKKeqX6BxnxUh5k=;
        b=deu/J9WapJidEbiYp3rFVm8mLFBXyeIKSgV08pyFQVQdMZQVbZOXHytIF+TE6mperF
         UiBf1F1Am3SRBGAXjghb8AkF/CqHSK7W8dd6MBRg2KzbvRH2MsUmfZ4ea4Qlpjcl5qVb
         nzeRPfgz2rMoQUSyNByohDfmDnu0BTi0vmtIisDUB1SViMLKlWwqyqeRYPgQLCmSCZfH
         98M61rPa7nlQwMtIwL0VnXHCmzW5owyjFKI3orP4Lbg4yxufiVkL4HjAgbxeVFdQ/ajh
         iYLfsbV4l89+EJHaBu5QmEHc1H2JisCODNqbO4+EdFXSn4IwEJ9x7EGhali9bxfclijX
         KYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639388; x=1742244188;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1Uwtz0E2eftoKGPgXBkETiGlWCcSKKeqX6BxnxUh5k=;
        b=YJv5pq5r5rDzPqzr4Y8c0jq0Wz1Law1Fj974oGxIWL5cJ68M/e7uGn1LeHDOllO5+p
         Oq99wRG0lFJAF1WekjBwU5iUWpxSUZGojdapG0QNoywk4SDATqQAltGD7zeb3wWLfu0i
         0QfQZNA1yco4sa0ojtrl3VSe50l2H+aYMZ0isfkeIYkLAo/IvhPucLvgqH6+cBRJn0um
         noWeQ1yp6zw8WYIQePMYHqwFPg/b1/3f34dwqIjoEQdRvCX5qXkDKgPNlOOlpgOOMQTW
         xM8IpImK7pT4jaNpRgzo5Au2N2fu+ilSKq88yLbrm+W1Hx5wLz9WLUTwL8kLOIIE51W3
         LxkQ==
X-Gm-Message-State: AOJu0YxCKKdnBlgKLOFuIEhdl0nQfK+FJN3FiIC0dRciab8MmRpB3gmH
	OdGPDA1bYl9MsiQ0jPra8ee9F7qy0nlWPnWZUa74chLgVL24USlfiV39/kE5GUA=
X-Gm-Gg: ASbGncvYmg1dyLJv7nEyFn6jlcDaYc2nst4zR1oCfzkCDmnEg7oIemuwdwWdEEmovtl
	9JmSpm+qGQTlyQeBLWQtW/IiaUx2RdYbcsKteX33n0wiW0KSODU80IJaPgJ8pG/dODSRMN5/gRC
	Bp9i6kl+5zkrVe6bgw5sA7OxUvQYaiKSZ6Z30ZWsTU83BoURVhqQdjec9xRP2IrwZbf1NPbniVP
	ehrKOOfyguiCZiwosHlNdCQt3jf0sdP/k9tKAPD52KNlau4x7YEtPhB9241zWd6OYdneY1rfFGt
	GhxENO6WDdN+RCZftnmba96rpB/msbPD9w81zbSnqHOEYEerr04Bxo+HsyAbSwsvGSW4Fztk902
	A
X-Google-Smtp-Source: AGHT+IFCUqL25r0cgLNxG0Su4KlpP7XmTF9Z5pKvu36TT/JlzyZ/GaccoxuJ0kue1KZ4WSuhE3fdng==
X-Received: by 2002:a05:6808:3088:b0:3f4:bc5:d478 with SMTP id 5614622812f47-3fa2b30fb02mr502464b6e.25.1741639387999;
        Mon, 10 Mar 2025 13:43:07 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ad4030: scan_type cleanups
Date: Mon, 10 Mar 2025 15:43:03 -0500
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdOz2cC/x2NwQqDMBAFf0X23IWNMWD7K6WHsL7WpRBlU4pF/
 PcGD3OYy8xOFW6odOt2cnyt2lKahEtHOufyAtvUnHrpk8QgbLZwnrQxSBTWGfrmqrnw57eC4c4
 yplEjYgpXpRZaHU/bzsn9cRx/MZClj3QAAAA=
X-Change-ID: 20250310-iio-adc-ad4030-check-scan-type-err-0858c3e3519c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

This started as patch to address an unchecked error return of
iio_get_current_scan_type(). Then while looking at other code related
to getting the scan_type, I noticed some opportunities to simplify the
driver a bit by removing some redundant code and clear up some things
that were not so obvious to me.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (5):
      iio: adc: ad4030: check scan_type for error
      iio: adc: ad4030: remove some duplicate code
      iio: adc: ad4030: move setting mode to update_scan_mode
      iio: adc: ad4030: don't store scan_type in state
      iio: adc: ad4030: explain rearranging raw sample data

 drivers/iio/adc/ad4030.c | 60 +++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)
---
base-commit: 66cadadbc94e18070245af7053f115061a73f016
change-id: 20250310-iio-adc-ad4030-check-scan-type-err-0858c3e3519c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


