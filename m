Return-Path: <linux-iio+bounces-23361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F30B3B824
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FFFA003A5
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A63081A2;
	Fri, 29 Aug 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmzOyMsJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC3283FD4;
	Fri, 29 Aug 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462061; cv=none; b=rL2GGOCXDjNdAuwJWbIHlCI+pCpIfQ/2y+hYqMreA/UIHese1vS6kTFBh+J0xCqbv/VMrERy15YSujAV6EvcAeRWqteXxLYv3VrHjmMTYBeJHbzrBkW4hap13Vci8FYSZ8x1sUAWx5BHwm5JyFlHtaRDULIpip+EyRbiX3hs2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462061; c=relaxed/simple;
	bh=xlzZpvpnlF9szsb6ciLkXdVcuaZUTR4t8w+9GIT2sMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpI7xRwh6P9xbiwRNACThmib20I0EAarR4mvisSp3V+I2E83Jmz5drzwfuxSTcklHg/jlWGyWD3qWcMQV+wNyeeA4SuHd17JXHIcvAHfyubB2YdUBtbUJNcrQVHLwCRMp6ve5bTY/emrCDN9ZKUOqJf7E4sAItIUj8RLFkrGhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmzOyMsJ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61dd3b5cdd7so468879eaf.1;
        Fri, 29 Aug 2025 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756462059; x=1757066859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBk7Y2iWMRq0omIsrbGFJSS7mEZPKHS+EpyaCaFiIs8=;
        b=PmzOyMsJtU3DcHkECNgXbphdb63ffTskIexmnF5HawBaarvqA1MXtLT5rTrm2EBWvn
         MAxtTmVDNPCFzIQGVwfv65c7CvtpmOpkK3m1XpCaSahXZes+6qpB4iWzHhFPwmKALFzG
         iqJwnh3TCdJQjpKeWDHcXCDHq8vjyF74UFmIP1xkRkpkC86Fb31HS4wIbs/XIUSVnzwG
         MJtjZC/swkJQHLMROK+/2zRZ0+mzgDeADDWRH8Lw9b6Q4hhJKP3WsK6uyJwm17gFSjYk
         u/VfheC6J8zVVsCaB3SOp//vIiV+/o35Wb1fJrTP8HPKgxfAzMzkfALmwdwlIkBARhF7
         p+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756462059; x=1757066859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBk7Y2iWMRq0omIsrbGFJSS7mEZPKHS+EpyaCaFiIs8=;
        b=mYFMh0hxSCdLv1Z37n8f9jMdGkHsp8xxWOfLFhn4e0pU38q+rp2U/Q5nsG5BYPQSWn
         ojwr0Aonoy31AhvoB/a1c0Zx5oHThaE9sK2fyslS32QlcGC6/AetrQ8RgaYd4/bqM929
         rBHbKofu/y5M7bVkedlaccavnBrVPO1hUWJ43ymKYVz7t4bUELk/CZsp4ZJPduyffRlw
         DZULIqid7DDMUdRC9nVZwKGLWQsXHgnoJEbT0GsO2bbxYRV2hVlUO0TuZ/fQDdDnrJ3R
         dBL5n9dMAfH/29vhPlFOqEoU/1BV7MI0Ihq8OTESo7/yxah0rntwXDmgZaPlnG3U2/Pf
         CKpw==
X-Forwarded-Encrypted: i=1; AJvYcCX10UC1elyP2u9ldmqh1WL4AzoMWRxo7SUY9mlZXDcIQAviNyvsJUsv2n40+jonT+R96qhE0Cn4ogOm@vger.kernel.org, AJvYcCXZDTvqd9CzslgxNVRRxJxN8+RPNSCYeM1JQI1r7dsN7M/UB4mRYF4mL8JNvgdhYQIcdNhEZFxLcZdf@vger.kernel.org, AJvYcCXtP+beD5muUE72mgAgdHVlhZlYVdqyJrlBlvNxshYwVaiuSFUByscdXWAq7vX1BcEePd6tvKEgSzWcge+j@vger.kernel.org
X-Gm-Message-State: AOJu0YytCua1+NeyxOUoKSRjC+AAYi9h8aE69JrPm1a3DxGPU98aZlDx
	NRzuyFBaw/7qr9dgAjC0yJ+OtYIwHVIXCL9aABf40+GpA1CsCmaEcIhmAmI/qCqVcsL1CaVN6S/
	y0N1Yhp9KEfdKfft3WzT+qWuQ90pXN9YF4EcovPw=
X-Gm-Gg: ASbGncsm/PbZjO/tSy5ta5aHoRnCEH8Vo/cQA2sDyBuO2gm3LMuIInP0CH8rriFhYuR
	+AB/EDMrm2U0T/g3QSN7x+7YEF0efpF/tewJGGhArAbihAubhgsVlWEICpV17vW3hkpmwcVOT5U
	TywmGYJ/4PbL2l3P2I2uQqTwWFqEjI3wnZIoqTPOr/NVR5AeQZlLiTLtMRqZj0zMtcXqp0ugtEm
	rU5vr8Xz8AdTJhVocAb/qw=
X-Google-Smtp-Source: AGHT+IGk8RMeVt/fJADqPDSRP6KA6wIF1G9j9WjvxgiJD8WWnKelP8KyxuFev8iaLjFKZS/+HLKE+pId4Rxaq0PtQqs=
X-Received: by 2002:a05:6808:4f53:b0:437:eb74:5786 with SMTP id
 5614622812f47-437eb745a16mr554694b6e.0.1756462058815; Fri, 29 Aug 2025
 03:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com> <20250829-fluorescent-delicate-pogona-c96b5f@kuoka>
In-Reply-To: <20250829-fluorescent-delicate-pogona-c96b5f@kuoka>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 29 Aug 2025 15:37:25 +0530
X-Gm-Features: Ac12FXwR0MQiuHh0zwiEuNw7iCVMWUBcIA0OU2ImZqD4BhBQugafXR3GPO9F1uI
Message-ID: <CAFmh=S3jKfGMek=ZPUrfgh9fXZaaq6zNBOmCyEpoe0qGpfbt5w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +INFINEON TLV493D Driver
> > +M:   Dixit Parmar <dixitparmar19@gmail.com>
> > +L:   linux-iio@vger.kernel.org
> > +S:   Maintained
> > +W:   https://www.infineon.com/part/TLV493D-A1B6
> > +F:   Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
>
> There is no such file here. Apply this *patch* and check by yourself.
That file is being added as a separate patch(Patch 2/2) of this same
patch series. It's already reviewed by you only(based on the name).
https://lore.kernel.org/linux-iio/20250829-tlv493d-sensor-v6_16-rc5-v5-2-746e73bc6c11@gmail.com
>
> Your patchset is still incorrectly organized. See submitting patches in
> DT dir.
By "incorrectly organized" do you mean order of the patches in the
patchset or anything else?
>
Thank you for the review,
Dixit

