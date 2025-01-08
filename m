Return-Path: <linux-iio+bounces-14021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144BA05D51
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0D63A6DDE
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2F2D613;
	Wed,  8 Jan 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6ukNJEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6111FCF43
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344086; cv=none; b=Iy4HO/HxkqhmHCwQAVlCYJ200xkq+bQjRyqtWTAmnIr9tQ5lzQMhvXQrCRflu5T5Qm24gtp/iIxpzI9hHkujy4whi6HhXnljqsm4o2yXB5Aiys/1JMZr6alIt79KU+qFwaVPKv0x361aYnlHGirZTfg5ux/4r8CLOC8AcO07Tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344086; c=relaxed/simple;
	bh=znsjLo6VWOSZKbUnJUFJk3KG1cANAFXx+t3PlKOXcrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a7YaCNXdrfQ2pPxEoat0CR/v1KyMorbkew+UuHEZBIYqfz2+qI/ozIy4XXKRsA6VadrF2xQwqeabY9Bxro5MggO3AVb0JOxAb06xQl7qsN3C5FN1sdEvJYenQUwLmKC36xU0o2yJoehlJDNHOdFTnt1pQHtULUa/NCNTm6jBRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6ukNJEB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so11007026f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 05:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736344083; x=1736948883; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbv3rAiDiFkkTzcHcbF5QCYOE0+YBP7jobbczHWnu6o=;
        b=G6ukNJEBZavRPST1yHGbKxoewzN7AtPLLEmE2isX05HYqdiPPCKSrbFc0zjkN6thah
         Uay2oc78VuieeFUzmt00pZhNdCi30/9HnJjGoaFPJHzVc5BfjcclbYQJjSmZtHxRjOWV
         V261miBn7J9FMeCFDdP4d9HO+Z/Qov7M0SzTYKFBjRYpAY+Mnnj+QDJbHd+g/c0Q0sHb
         wdjJqfMRcNyArjhijWOknvv2lqqBXwMYzYRw+0OfmHzwJmnRfnH37OGrlGa6yDgg4qYl
         4KEHrelkyGZJpDSccb7zqkICVn998eWsdwTy/pTBtMekr3WbgE04brtJnsSBf/T3cq2h
         8dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736344083; x=1736948883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbv3rAiDiFkkTzcHcbF5QCYOE0+YBP7jobbczHWnu6o=;
        b=aAayvJ8iR3wjkJTtK49aoUr3JunRP017rRYC6nO+HwQDukNJzqd6LJETQsR8KcEytC
         mem49ObmDZ5NuPI7YYSGhgY1dwy19GcKyw/5fJ4JOcNXF61XNm2f/gWIA+IOvwJt20Ui
         WRtDaijj3y1nbQO6EkgxjpVg26aqLjsFQD+BNPyxc8URKz1xUDfdrimW9dxnfVQbSqid
         +e9IYugqtQjxbYmSOKRNqYc1bnRNVrhLPzPzmnBJ5eRWVDnq4PabvwCZsytKEr60zc5w
         rfX1732rAoiFzk6Nv4zamglfWfemrQj6z2m/yBijso2fQ3IT37JOPOnrz/rSyjiker60
         IuJQ==
X-Gm-Message-State: AOJu0Yz2xgOV10pQRIE6fNEjpvdS4GywZhqc+I0Tt6OQ5dBsqo9zzEti
	xodDkZHUoQoi5nTqB/TxYJe+nio59Yb6q66m9ahM1LS+Do8N9QxUXw5hg8o3yLQ=
X-Gm-Gg: ASbGncuK+kmCElIORguvXT0/I6jnEcuCKOIulgywfJQoFdSbAELSG1vpHpShkVp8bNL
	xJSXZHEZfw965cPAeTzxZZuCUr4V3EoxTkCPVuOSG/eXB+YAhvh6p0LqoY+u/y79SiXqy/v5c9Y
	BcxW5fHcSO4yt//8g0nI69x/wXyCCS37KOeKLtiFboodva8Ega4hmQMSH/ZOSCiS+neZQkxuWGn
	Wk2J8oAF2BD1XMBnCwdkMEnvSfcCDw+hS7bn1eeoIqElzQxdn/8mVKGlMOCnA==
X-Google-Smtp-Source: AGHT+IGVn+sxzI0kLs3V8InTkJfpDOuvXWLbRM+24secZNA6YjCumP34xFUZtVPaLPvoZvIO2TkNBg==
X-Received: by 2002:a05:6000:402a:b0:385:f23a:2fe1 with SMTP id ffacd0b85a97d-38a8730b072mr1972814f8f.26.1736344083236;
        Wed, 08 Jan 2025 05:48:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1a1sm52343741f8f.69.2025.01.08.05.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:48:02 -0800 (PST)
Date: Wed, 8 Jan 2025 16:47:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Robert Eshleman <bobbyeshleman@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: light: add driver for MAX44009
Message-ID: <11cbeb15-c6cc-44b4-80b8-223d3f5c83b2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Robert Eshleman,

Commit 6aef699a7d7e ("iio: light: add driver for MAX44009") from Jan
31, 2019 (linux-next), leads to the following Smatch static checker
warning:

	drivers/iio/light/max44009.c:309 max44009_threshold_byte_from_fraction()
	warn: potential integer overflow 'integral * 1000' 's32min-7520256 * 1000'

drivers/iio/light/max44009.c
    299 static int max44009_threshold_byte_from_fraction(int integral, int fractional)
    300 {
    301         int mantissa, exp;
    302 
    303         if ((integral <= 0 && fractional <= 0) ||

I don't understand how negatives are handled here.  Was || intended
instead of &&?  These values come from the user via
iio_ev_value_store().

    304              integral > MAX44009_MAXIMUM_THRESHOLD ||
    305              (integral == MAX44009_MAXIMUM_THRESHOLD && fractional != 0))
    306                 return -EINVAL;
    307 
    308         /* Reverse scaling of fixed-point integral */
--> 309         mantissa = integral * MAX44009_SCALE_DENOMINATOR;

If integral were INT_MIN and fractional were any positive value then
this multiply would result in a integer wrapping bug.

    310         mantissa /= MAX44009_SCALE_NUMERATOR;
    311 
    312         /* Reverse scaling of fixed-point fractional */
    313         mantissa += fractional / MAX44009_FRACT_MULT *
    314                     (MAX44009_SCALE_DENOMINATOR / MAX44009_SCALE_NUMERATOR);
    315 
    316         for (exp = 0; mantissa > 0xff; exp++)
    317                 mantissa >>= 1;
    318 
    319         mantissa >>= 4;
    320         mantissa &= 0xf;
    321         exp <<= 4;
    322 
    323         return exp | mantissa;
    324 }

regards,
dan carpenter

