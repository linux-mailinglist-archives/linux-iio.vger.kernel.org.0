Return-Path: <linux-iio+bounces-14470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FDA15E47
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00F9166306
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A41A3AB1;
	Sat, 18 Jan 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ODHLh0zy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0119C558
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220456; cv=none; b=lXzU06M1EBmZn6jzaMAi1F3wN1BycVkYf4DErMcQ6GxfQ52nfsjVP59bjbU2yydj4AzlH9IgTomfkoY+5n4EXJhZ871sTQtnTVlZOkd8dv4EM9yN6s2u8iISYM+MO7Nx5DhLxALRjlmuKYYptiLMFFlmg3Tg1K8hK0XadfOp16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220456; c=relaxed/simple;
	bh=gjsIOVX+ye+4kEXYWaQMgX6lCE4ryiEwsbDmLGNLT+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mm0+vNgz4UbTYU+MobvEbtVuhvJ/lsrXAEJXowGelKVf9+wQZIZd2KgY4xJdarRXbMuOV7nPFJKVU6eU/JBRlT/bpoo3z3uHDdvMUbQKeYqzdeI4KRLhQbAiTp02NEe2CMCRq3h+fniuTjvgbb32Ci99Dlt6K2AyRiF+Ym7yH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ODHLh0zy; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f88b61399dso2169304eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737220452; x=1737825252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZPu6FVwcORY2iGxdLdp/QzMj0EscoJgxJ/cxmxbvSc=;
        b=ODHLh0zyOv67DqfxlJJDkkyTXoelvLHiejmt6riUHUEJvPIdVVkFCoXFMztnj4vxrg
         tSzl+npbn+UtLI8qtr0IN2C01MB4hpv0d9cJPBCAXpBZegUjmVrp4atWdu0u/vmEbJ1/
         umpmusOrB4D/sMq8kKBg0z87SzK154+MQvFHMtOA3KuAkHisTmLNdbGwUEIQNpcjwRXy
         Sa/E+o0MgCpcFIFyUzTWnRW8DlpiAMbFOj4LwLrrDv+I3ouck6on9tuP4OAK8LR8V6RP
         zuxLMvztn2oKSmK7oCO43ozyn1Ukyu2WUuhNfTRW9GN998OELCiniNZ4eZUkfAQxWu8R
         Iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737220452; x=1737825252;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZPu6FVwcORY2iGxdLdp/QzMj0EscoJgxJ/cxmxbvSc=;
        b=V9ASKpuHSIwesg6IzZsUa6OPpxS+4GVqfOUj727LZCUCXNVVm4pimjoaKE42BlTXLg
         3EFsWPE2iclgR7FPfkLzqViktEo0/K0MNUxTR6bOQk2Zw2u+uy/3QSTVqzLA3LOIx4sp
         rlyTd/VzKNkOhyf4I+rWwtHLndpQuFfEubTV9pkOGxqLf1eUxiH20SWlmD+iKTHZTQhO
         77LBy31Q9KIRNRuy+i5F5rNrpRJe68y4+Lh2ExM/6Qs4BwYH+QhQrsAAD3BV12vyTuoH
         RBJzD5sn0RbSwmJaQX7IB+vzFNTXaTgtoP7XN3Hi2rB2ZVUE4I4QfbkvAMt8gKmU+rYK
         U7iQ==
X-Gm-Message-State: AOJu0Yz9p4Gud5cY5iHsGIhRuB7juaGLSQwHsl2L0Pxf3ZkF1lWeONO6
	DAHM6EDdhtq5TdQsmWUI8hMe2Xh+mglQXmeNrIblEp4yLiMcpndUaPgTVA0jlgU=
X-Gm-Gg: ASbGncvcGJalkrC6KpZc8Ce8a6KrvWXIb4vzgmCytZs+Crdm2aoYqjysaqy90EiGa06
	KVRuwNUGq4ORkOyBI0d2KosWL8yhmAp2jLQWCBhbSbPtP1Hl2nzEr0DWzLEQ7hK6HnwjOcPBPEm
	LNSwRNyDUxIkww+V6jvwbBGfNBwTxTjc2/I2DI5y2gyXUZQXsUCSzW+0ocnhswzusZgSVia6IlE
	VX0mx++b0iWqw1BmduD+PExhIYDo019mlNXXdXJbR/F0+ClBeQvez91J9RuhLa0UUJcNyPeRIq9
	qK5DYH4axoJtnRUvH6h4WT5aIEjHPy4=
X-Google-Smtp-Source: AGHT+IF0KQ8N3yID9WKJ8pbLob3laSFOdEDYikjZQRGsX6bfpyeTJuEoWKPbPTkbFuS1VxUtjjfgjw==
X-Received: by 2002:a05:6870:7f18:b0:29e:3d2a:a4a9 with SMTP id 586e51a60fabf-2b186a3f900mr8911931fac.5.1737220452365;
        Sat, 18 Jan 2025 09:14:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8ce8777sm1812904fac.14.2025.01.18.09.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:14:10 -0800 (PST)
Message-ID: <938e5570-8e56-4f8d-aff2-3c6354f3330c@baylibre.com>
Date: Sat, 18 Jan 2025 11:14:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/2] iio: introduce the FAULT event type
To: Guillaume Ranquet <granquet@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
 <20250116-ad4111_openwire-v3-1-ea9ebf29bd1d@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250116-ad4111_openwire-v3-1-ea9ebf29bd1d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 9:01 AM, Guillaume Ranquet wrote:
> Add a new event type to describe an hardware failure.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

...

>  enum iio_event_direction {
> @@ -128,6 +129,7 @@ enum iio_event_direction {
>  	IIO_EV_DIR_NONE,
>  	IIO_EV_DIR_SINGLETAP,
>  	IIO_EV_DIR_DOUBLETAP,
> +	IIO_EV_DIR_OPENWIRE,

I think it would be a good idea to add additional namespace in the identifier
to make it clear that OPENWIRE only should be used with IIO_EV_TYPE_FAULT.

i.e. IIO_EV_DIR_FAULT_OPENWIRE

>  };
>  

