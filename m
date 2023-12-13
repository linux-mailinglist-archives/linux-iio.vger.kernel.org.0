Return-Path: <linux-iio+bounces-873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3AD8109A4
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 06:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7071C20A67
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 05:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EDD29C;
	Wed, 13 Dec 2023 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZiiiMrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D528E;
	Tue, 12 Dec 2023 21:51:09 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d33574f64eso66442097b3.3;
        Tue, 12 Dec 2023 21:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702446668; x=1703051468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuCbUQb5WegONcfx1OBAUOwkSNfrcmV4RrW5gKHhwH4=;
        b=TZiiiMrNdupuOEKUD+OTjC3OSHDF9KnPZZLhrHVLmdTFHfd0E9dprZCBwJxvjv3z58
         jjrhLlzF1iqW6iGkVJgoWz9d6BSazMCOETDwjrS+/wTJPdiYdl+qoliV/oC9IKTp+Eqy
         fIJMqzRDLQ3iKAPUj3bgnJk7BRj6TcnN91p9nigAIRkIsO78pSwxa/C2yB+5A57y9Z6c
         IUZNU14FMocqtlaLws/fdquNSOmSD7hJGfHAIzcdsDDTqYQ2h+9pnxB+6Q3IETY8oY5l
         QjcXxknqo4nNurBUy7fHrWvrymQG6SVOnezBFW44KRjPyr3C4q9BTwqAFufKH98jmUy3
         oU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702446668; x=1703051468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuCbUQb5WegONcfx1OBAUOwkSNfrcmV4RrW5gKHhwH4=;
        b=TXptA94io4KfzFKVwVOVjEBhf3q+uEzegYMMU8kZ8XJ5ms3E1CxRsHXA+mwgRnKDJC
         Re6dRtX8FPFGLcADcl0t4bT1e2sgdcLUVXejfmbAv2eb4deltnR1dXto4PgKHCwXrGpb
         UDRqE3QC6cqtpvdP5IjXJyOLRtA4qoqML20VGAnCYc/VD4gqFd66ebWG5hafx/rJYWaX
         +WN891pLYMzX/2QKrGRzrpXDHfrXgU7/YWMqQmzKoNTpH/rZE802xoi8POazVQOYnX3j
         4dnrTsBBQAiS8Dn2LZKD8W7x8Z0Im24nj3qT9oaWYTR426ojl/sXLeAy5cshFfluzyd7
         ADRA==
X-Gm-Message-State: AOJu0Yy54KwWLmaXmhtDEv18Hf98RotUfBu/Kp65uDKLMzQTWBogfFeE
	J7LKcaXQAcMiorlbbasZ4PDGRArfSUSKEA==
X-Google-Smtp-Source: AGHT+IGHJG5AwQ6ERukPWZk9JkCzGueszXfxLlvKzK6e/M2zt812hcssOa+hOXZob7k4FVv2WFZlEw==
X-Received: by 2002:a81:af66:0:b0:5e2:5d4:6f17 with SMTP id x38-20020a81af66000000b005e205d46f17mr1884372ywj.43.1702446668472;
        Tue, 12 Dec 2023 21:51:08 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b001cfd049528esm9573609plg.110.2023.12.12.21.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 21:51:07 -0800 (PST)
Date: Tue, 12 Dec 2023 21:51:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 01/37] dt-bindings: input: qcom,pm8921-keypad: convert
 to YAML format
Message-ID: <ZXlGSPTnineYmTyN@google.com>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
 <20230827132525.951475-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827132525.951475-2-dmitry.baryshkov@linaro.org>

On Sun, Aug 27, 2023 at 04:24:49PM +0300, Dmitry Baryshkov wrote:
> Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
> PM8058 PMICs from text to YAML format.
> 
> While doing the conversion also drop the linux,keypad-no-autorepeat
> The property was never used by DT files. Both input and DT binding
> maintainers consider that bindings should switch to assertive
> (linux,autorepeat) instead of negating (no-autorepeat) property.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Applied, thank you.

-- 
Dmitry

