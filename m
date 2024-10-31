Return-Path: <linux-iio+bounces-11714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC19B81F2
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 18:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914BF1F223F3
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54371C8FBA;
	Thu, 31 Oct 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE3YMvI3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8AD1C2456
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397485; cv=none; b=C9sSmtQCR4mCbB0MiihFD54hgAxM4zwtv3Ph9b+qh+4hC4vTCrtw9JfJ/jMJHoMcKa672rnogQTx91UDE+vFpAiqJLyEW7DaH7apzpFYVXdi07DkcNj+0RTZb4s4llRFZaFHXfJmylFHmYkMb/acAWwlF7DOcWWKDu9IMQ5w/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397485; c=relaxed/simple;
	bh=s98ZX28OsVpUZzWaaWrFm/+3vCU+Pr78M3qXyvNi430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVupOeSnnef/nDJcdBBkg9LPdiPBpqhv3uKoLwtI7aJLN7sTfafmSNAlJIRtottzdFjzDoGiS5N9Zqy5+8ax997c501nv0ZRSm47KQ/cyV8KbvETvLqy+i0YfzTQzy16wLl6inNMvzPSjlqEAkIi29V9UKLNDi1Fu1ZJvbB5PdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE3YMvI3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1343512e87.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730397481; x=1731002281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P83QC4divwjdwrOkzc0beaK7x66pdeMqgQ1qbe4pGZQ=;
        b=TE3YMvI3gX8v3czSKkqhq73RscaYYFOYVzLdo4u52ig90xybOIIpbe5iR1r5IMPxdr
         0qMZaYYfEaEbr88BieHkHhE1TBpfSZ1mJtr4bwI6Tfk9x9bzfu/3GRanxP+wSSZeHAqc
         8zTnpenvflZw391sG/a3Yp7wHaDJs0xbWcnxo0kJAByYxCvZsZVF7O6BwsuV9xan8VJW
         DHqdjRep895ikJ+hbw53gWmZRtii3CwsSSuWV9tklMhJN0rLiCUTaGusecGgMUtXvyF9
         o345UfGapyOlYSOAGu4P7gQtZ/mAxFl2vbnw4mKEBIDsLdX1K2gXKWyNw4iUtrGk0Wrp
         H3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397481; x=1731002281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P83QC4divwjdwrOkzc0beaK7x66pdeMqgQ1qbe4pGZQ=;
        b=m/JZnUyZlkYi7r7pnKyasS8A+S63r0vT5VFaRiGuISe++Qq5cf/J3NS7gX+p23CQtH
         VbbL/VtDDfzsmP3PY2adbOmonDdOTl41Mg8p2PUFnuJddH2jiJ9hOXGonI03QFAjq+6B
         ZSq7OLArU4iOe7pLz/eZtGPuaPjVck45ywQfz4fcDMGqss4/fzM14B6lhlgb6e74dw+q
         k4kCrnuDIGgMV6LrA0DgKVbu6P4n3K100OfMquGknLufyEu1K3bAk7FufOD81+1ggvwN
         TEkWt5X5vl8efHRa8jV5IxdDs4xweFkRSi8WV/fNr9HknXVdmoEdDAnSPqi1a8Z/zTDg
         7M5g==
X-Forwarded-Encrypted: i=1; AJvYcCX/HJAhfNr4hc4UZM/mv9MpUSKk741SuFupVB8aReseElX/DyJFFOG4MBE7N7UqPmkTwipt9sjvfpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXnn0auL7OsA7lV5r7bLpKyXkAFT2r3kivBnAp0QNXFPvyhT6
	V5JxMO04BvTDTxRB+uCVdxeD9Rz6sm34O+0BbWKYmTGtdFqR7b3pboAX5LhFQYY=
X-Google-Smtp-Source: AGHT+IGSV5srlEIwYq4ukshM4Ah7sMYFPuqhx1GlJEoXoE2aV6eQnDSC8Wx080gm6OXkRcNzRUro1A==
X-Received: by 2002:a05:6512:687:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-53b348d6ademr10336086e87.24.1730397481275;
        Thu, 31 Oct 2024 10:58:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c9f3sm282595e87.116.2024.10.31.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:58:00 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:57:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org, 
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, quic_amelende@quicinc.com, 
	quic_kamalw@quicinc.com, amitk@kernel.org, lee@kernel.org, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com, 
	neil.armstrong@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Message-ID: <ag3wqsjdec7ujcba2jpvhzgcbbc5vnyjyes5ljyyf5b4edw7j3@rj23a25wvoyd>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030185854.4015348-3-quic_jprakash@quicinc.com>

On Thu, Oct 31, 2024 at 12:28:52AM +0530, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on an SDAM (Shared
> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> channels and virtual channels (combination of ADC channel number and
> PMIC SID number) per PMIC, to be used by clients of this device.
> 
> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
> Changes since v3:
> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>   instead of adding separate file and updated top-level constraints in documentation
>   file based on discussion with reviewers.

I think it has been better, when it was a separate file. Krzysztof asked
for rationale, not for merging it back. Two different things.

> - Dropped default SID definitions.
> - Addressed other reviewer comments.
> 
> Changes since v2:
> - Moved ADC5 Gen3 documentation into a separate new file.
> 
> Changes since v1:
> - Updated properties separately for all compatibles to clarify usage
>   of new properties and updates in usage of old properties for ADC5 Gen3.
> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>   mentioning this convention.
> - Used predefined channel IDs in individual PMIC channel definitions
>   instead of numeric IDs.
> - Addressed other comments from reviewers.
> 

-- 
With best wishes
Dmitry

