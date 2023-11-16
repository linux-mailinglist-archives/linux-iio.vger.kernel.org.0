Return-Path: <linux-iio+bounces-109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BD7EE190
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572DA1F24078
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07830D10;
	Thu, 16 Nov 2023 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLszVHLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3384;
	Thu, 16 Nov 2023 05:31:31 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5b3b17d36d5so16333987b3.0;
        Thu, 16 Nov 2023 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700141490; x=1700746290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfiuMGKhBfphWIUturZaCUkLZwNpGAf3qvHrSRN2raQ=;
        b=HLszVHLzmQEbn/vhxv6vxBDhGBSocl4cvf6vFLXsKjInozK/WErQw7IlZnsn4pVQ1p
         Mxt9rAL/Nr2EK4qAbTSdWlUfGEB9tu4Wc783LZGWCjq3hGlgHcHKDyEhc/YOoPBDrrbI
         2gy9GygRYnyVxwHSL+8PIlJci+MZQLsN2Ap5RHDyfWJ9VtJhATBVOXgnK5UDgXHUVsNs
         PVneV+qJZLZ6Xivc2AUL8wF+xFv3fxxr4BIr9XnIaSdAxeK9s1Xqvr2wMrR6U6AIgJAi
         8og+YbkFpoT36+eFnczN+eqO/J5XtG3CyNtotbz96Zykm2j+wkKVKZwrQUg/2K38m7yW
         Srgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700141490; x=1700746290;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfiuMGKhBfphWIUturZaCUkLZwNpGAf3qvHrSRN2raQ=;
        b=bjUbUErqdejKNisfkCCodU1S015MppHcbq4f/BwqTe4/QA+oYSpo0U14vx0QZGnyAT
         gJfYosD+lPg4UO7EKTDvZ2VRbatQMcGOWyKNgIDOm4lFcfhMBHxCXvSifiXMi+U70opj
         zC7OHAAruAP1B3D3PbJmNqeyPKUMw96f5FE2LiGY9iyxBjMb1lDDS0dLeUnxx/niS9WK
         dlC0+X6wk9BHs7llnTACTzQVfuIuTXrn+fIK+LYsj2I3XXLILuSwIbeRnRNR2ZhoSM/y
         zfD9Vhjengfmvkv6e9o2v1UJ7ypTfopG0btynouClJVlaxz0wQRaVLtX4ZqdSbc3+FrZ
         QhIw==
X-Gm-Message-State: AOJu0YxgceXFt6Yta7wHqiEGLuDE13YkQsOTQVzaRvNGXO1g+nCh+hwV
	glqJnqza7A3QgvVi3gel8thPt03bp7Ls7bYTdok=
X-Google-Smtp-Source: AGHT+IENFOmg1lrjmrVQhozbiwA6K5ALsuBEu2RtIkJ9gRcHAoKLmt2cXls+8xeDfYonSVUglur2ZwnnwwK9qkmkFCg=
X-Received: by 2002:a0d:ea51:0:b0:5a7:dad3:cd21 with SMTP id
 t78-20020a0dea51000000b005a7dad3cd21mr940109ywe.10.1700141490180; Thu, 16 Nov
 2023 05:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116125433.13285-1-579lpy@gmail.com> <20231116125805.13466-1-579lpy@gmail.com>
In-Reply-To: <20231116125805.13466-1-579lpy@gmail.com>
From: peiyu li <579lpy@gmail.com>
Date: Thu, 16 Nov 2023 21:30:54 +0800
Message-ID: <CAELPsEYKgmcPh=9FQ44d_5AwHYd15EzASEKV31Gcv_5rdrPJDg@mail.gmail.com>
Subject: Sorry,please ingore this email,this one is no is no different from
 the previous one.
To: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm sorry that I used the wrong patch name when sending the email.
thanks,
Li peiyu.

>
> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
>
> Signed-off-by: Li peiyu <579lpy@gmail.com>

