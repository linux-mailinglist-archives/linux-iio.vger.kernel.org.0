Return-Path: <linux-iio+bounces-7574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9025930175
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF601F23035
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9749634;
	Fri, 12 Jul 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M+KXEAFw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAD48CFC
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818477; cv=none; b=cTvLhfWjlMuNVz2RAaEsaTZfu0x6T3ZYLSHf3wc3QTX3dSgyDgXEREff++Pc+YWFBLJCmGQVJqj6RYs1TPFP6EVUEdwahEFdbhZwlpzEXdWayh+UA/QG/Y/xI5yXbddwxBEePSqVOjKhSdMxpJ2xsUKdCuLcxvHowJdCUjXM0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818477; c=relaxed/simple;
	bh=7Cm88/6Mbf88RzoSxmJ3Qlv7IJR9YSotepXJlOAWIic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbJZ4O+jIauuzbzRiOimQthOgx9mLVq6BbQob5R2IL8IvWTFUxXlb79idZI6xgqW+8eO6NMRYd+cOvVtHu+mxQYlsrTnGhl9Ehr3nhHLYTYo3A5uSCgM+Gtj0DonYKgoYWj6c9iBOk/9Ih1Yh6id+wV6QTw2ir5GA6GAD9IWyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M+KXEAFw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8d0a1e500so1929018a34.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720818474; x=1721423274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fq4KkMj11vqcNNXM8EwtAU8v4pHupusWEImjez7Pt5o=;
        b=M+KXEAFwnDkvZpiCGJ1fZBhp+ECUJoLb+t8gUqddAEjESnorNvqc4x5Yy2ZzYdLqhu
         yErgtzqaO5hT4C+kbLqYPy8uWwG8o9NbqWHM7tQ5SuzB1B/zhe8AnLDHwgSnnFHapPdv
         9WpqEDpSul9u+Ut79lBDy/OPydoss4c2vieQ9SPLRrYJyLFsQlSGoNeqVx0H9mBdZ2FO
         CEHjw2pQnKzg2ae7NeUy3I0xcUmoJKnJ7gz3PMzTjUUnGLh7cWEQD0jIRLal5H01G0u3
         A75XB0EG7mJDIqBfjdQhNrRu/T5JnOev6OrLrFCkhwWOdYB7lXtZR8mt2Yu4UokMU8+6
         CVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818474; x=1721423274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq4KkMj11vqcNNXM8EwtAU8v4pHupusWEImjez7Pt5o=;
        b=QYMZ3vzDzRf7/NHoJ+ortCgx3SHqTPR36ULrtNvq1GFNR3gpNwR0+NltPJY3m/juFk
         ZIwPJmimzjun31hkPLsD/1n/pGGl3O2DQim/cXvVqPdgdYz4oLO7TyS9BUccke3sfs1O
         jIRcepZFMUwnoYcW4ov6GgAlqX7sYgeFRUC+pOySE+G2ZkokpcCxof0cMlLTmjTAWYwD
         HhQug2S06848dCAp9T526+hFxo38Du8cjoF8dzxbi5bYo787M/rJWnHMZAetkcjOLHy9
         TECaJ1S08FErRrnrfthJdTyZBLd0/Vctzu1p1XaK8eC+gveBHTXFdtFcbrzN/lSHeacA
         oOhA==
X-Gm-Message-State: AOJu0YzA+nk1g6Oob80gcuBF5x96rDbTGRCnKR9ac3+QUEpPmqDNpQKl
	pOwEnqtlpSUWopsQmezowhphWDEeWjnGBsDtt2NsvSff6Glp4jMS60eeVNVla5o=
X-Google-Smtp-Source: AGHT+IEoXuUJo/PhE68eMUnJlCNcQbocfp7ikjcwp+WLVN3kx8wks5LBo4mswSpy1LlRkxQBiHpZ5Q==
X-Received: by 2002:a05:6870:700e:b0:24f:d498:5e01 with SMTP id 586e51a60fabf-25eaec6da3bmr11467594fac.57.1720818474317;
        Fri, 12 Jul 2024 14:07:54 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-704495a9e0asm1130090a34.81.2024.07.12.14.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 14:07:53 -0700 (PDT)
Message-ID: <5d1f63b1-5196-423a-a967-5fb2d9fef979@baylibre.com>
Date: Fri, 12 Jul 2024 16:07:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
 <98c82e0a2a868a1578989fe69527347aa92083d7.1720810545.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <98c82e0a2a868a1578989fe69527347aa92083d7.1720810545.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/24 2:22 PM, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



