Return-Path: <linux-iio+bounces-16177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42084A4956F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D3B3BAC20
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652525A642;
	Fri, 28 Feb 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2nTcNqb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414225A2D6
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735348; cv=none; b=foaQIbLZk8uDQGRTdt1K74Kt1DQgTxEGZPjveDvoUuDn6pmw+Ii4avOQb3PoPBBLzqvfLy4tOJNOL8YAM5JRRlrh9CZZPtr4wI1TQ1GLCFtQG5dhsylCgaqNpxm5zdLytUTvRvzd6m5xp6s3gluibW4Nmp1cSN/L4UdajClYfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735348; c=relaxed/simple;
	bh=5wwhbu7yvxb8Pu+sWhd2Bfw0yE+/Lbj4gK2wMJKPvhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/c+b7w0dJyA3qpnzLW33Uz3Jek6bdK3ooiA1ernrZ1spV4lonmd2bgi14n0Q5sQsMuxyzzRPNfEZcNtkSXnhV8wnSnGXwVQDxwpTyF4F5rVlOjirYU322eDpV7A19O7YwTV2A5swDZ+0g0r46iYrq2QIg47A7Srs00F5ejv6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S2nTcNqb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf3d64849dso29537166b.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740735345; x=1741340145; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAD6FYOZHQiIZ5qOdMszeXmFSAsXwpOb7J/vlvlF0S8=;
        b=S2nTcNqbD08AgxKWtjNavPRZncz9w+yhc3VXgTadPiS8aT++vZnTP4tb2PZhFSnrtZ
         rDOk6gXPxctH/P9ZS1C50GLw8m39VJtozc8ifmQLUW1goyKWkmYhPpMAn4eW6rZBHgfW
         LYqUybHkCSkyL4M9GHWbDp/NNZM3whGS3V5ZSw/qgxpJDqF/UU9y43aQDblTZqG3CXcG
         FvTAL5/qYiUf9Xh6u2zgyBx5H4uu46ZHQpeV7ilf98Kg3EQpbYoUOK0ikOkZziqbc/ok
         Nc1pbzhr0YMQRoRmMCgdP7vc0RbbypR4LLDOIc7ho9SLFqG+Yk2ZNT8e3ONtXdNOTIX3
         AGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735345; x=1741340145;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAD6FYOZHQiIZ5qOdMszeXmFSAsXwpOb7J/vlvlF0S8=;
        b=Vh4RWmPLRpWvNeLZuWS1GGwd1PEQeMppOQvy7GZkHDLRUXIwzR63yTxzPjlL9lhseJ
         Fkae/7Z1LQleUdgPCtrPSdzC+RvTOe3uwFHdGNNLogrIYgeL0lWpAbECATtIShIIVemi
         eImYObF0aO7bxq7ySSDGf9/boawOpu+e4GRmESAtodkwrj1xtTDZV7rB6y1UoiMEjOhn
         EwV3okMh8XSSElHJyG1NOi+QTiCPoTgckV4Sv138BeFZuZbzKBPSvXt47XvfvHN3QccZ
         Hpih33v7MFo9Jdt+Z9BlMP9ZuZiXhGglGwngc9RPs2SBZjswLITqolB+WqNryuBvA1fy
         /oiA==
X-Forwarded-Encrypted: i=1; AJvYcCX5zKazcr+ToSMcWwyLcJxkhHOAG/2tUQ3pI1rx0b7vCi8dc9H+qRE3PfDpeNqWKlR33cswrWIoFAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5r4z+CZ991+nBN9NXXiXWR/xEcQBJ1O+QHhmIwcsL1PBS3VX
	uNx8Pa+3PuiLJl3YgPyp+6V1oKo//PGZlqREhILibHVB5AWMKDR5eZ76xa3Z0hw=
X-Gm-Gg: ASbGncs08U5EvvoOuCMznLPKaxLb4gn3ngezaxEF4BeioO16Q9t2YWiB0bRZoY3YZD7
	I3KE9AHvTsb8nrcK8XuFpHt/AmAvICxtYPQh1EcuQy31zEJHzWlCR+AZ4A2rmiFNntqfjFv+KUg
	NSCsDPULLxJt4CR59uBc9G5XilgFXQ7WMIkDuUUuKg3WrkWhNsY2h5d2GNFcTigmSiYOqeLIuyN
	VSJUcCMwtsj8JkrARwfSAell+6Gri5WKIwKy6F0iNjvDHhR/K7BLLKUz2EPv77z4XpJGI6ffdoU
	yDHRQlJNSalwFjtHnmQNwbRd9RcOqWr+FleJz5kwAYm+ooBdYA==
X-Google-Smtp-Source: AGHT+IGnFx7Ob6v6SoU+/gvpn5S5yHkLF9q6yTrtLPmDhB8HE6n8VTxo2kQ9zk5VwAQD4u4VOZdwTg==
X-Received: by 2002:a05:6402:50d0:b0:5e0:818a:5f4d with SMTP id 4fb4d7f45d1cf-5e4d6b628aamr6127584a12.28.1740735345024;
        Fri, 28 Feb 2025 01:35:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf42c16af2sm1976966b.116.2025.02.28.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:35:44 -0800 (PST)
Date: Fri, 28 Feb 2025 12:35:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: adc: ad4030: fix error pointer dereference in
 probe()
Message-ID: <cc67cee7-9c65-46d2-aae3-f860fc3cc461@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The intention here was obviously to return an error if devm_regmap_init()
fails, but the return statement was accidentally left out.  This leads to
an error pointer dereference when we call:

	ret = ad4030_detect_chip_info(st);

Add the return statement.

Fixes: ec25cf6f1ee3 ("iio: adc: ad4030: add support for ad4632-16 and ad4632-24")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
There is a second Smatch warning which we may want to fix as well:

    drivers/iio/adc/ad4030.c:397 ad4030_get_chan_scale()
    error: 'scan_type' dereferencing possible ERR_PTR()

There's not error checking on iio_get_current_scan_type().

 drivers/iio/adc/ad4030.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index ab5497c8ea1e..b7caf7e89710 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -1014,8 +1014,8 @@ static int ad4030_probe(struct spi_device *spi)
 	st->regmap = devm_regmap_init(dev, &ad4030_regmap_bus, st,
 				      &ad4030_regmap_config);
 	if (IS_ERR(st->regmap))
-		dev_err_probe(dev, PTR_ERR(st->regmap),
-			      "Failed to initialize regmap\n");
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
 
 	st->chip = spi_get_device_match_data(spi);
 	if (!st->chip)
-- 
2.47.2


