Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C5190B9A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgCXK5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 06:57:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40209 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCXK5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 06:57:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so460140wro.7
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DOA10CRKFJGu8b5wtBJ2yLDJfOkq/sBVSQmhdUC4ypY=;
        b=XzPL8rmmIVLxiwmtlWoRSXM0V5GpXguC00V1OiwP6D+VNJxQu2ndjNH1DMpUjS28PQ
         95d55nIqF92A5FJDVtQG8Jzb05LrNkZmBvwRk7n8ylcgjn2PXRej0umf85yg4FJtwRIf
         1d6lguSarwuUd5qHDfnSxccZHHNay6tDtznC6eX6gJLk7WG884AyXPo8Re0uFBwUCYRa
         EJvXYkjpEwuOQ+odcen6exRdljEbPs65kh1We93B8zHf7DKnQ9qYQGqCQip3Pr7KLhbt
         MOAHL7oolr6K4tZz9zakUdiOTZZ68VaGyLG81OjlfADYwnOzGldnrkt5IBYVDJai8PZR
         9zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DOA10CRKFJGu8b5wtBJ2yLDJfOkq/sBVSQmhdUC4ypY=;
        b=syEL5yLByLBHD9KAt6FGSKNChFLRv7C4HGZM7AszNaexLl9urvOZru4x7Ma8aRzZTo
         Tva8+9N1xTwdLgMZx8TGF3JYLP+tmUvfPANiGnmPJpY5TVVS2E1sjvwxg25I+Dt+unD5
         azJf5jjIamStj0hpON0Q+q53CMLFK3qLTEPBGI+mIagE5i4R7KcLtd8QMKuN4amTZGU5
         JhY1JGWeQlLR2ZQ08IPTIl2hrWWCZ3oHu0B3HikXgbYmids4wiOUWAdhtQ9B0QaaKNgB
         pm+2zOLxcff3koONL6m45IWq0nu3RsI9Q63bpcG/24jsR1+dkrQNXGM94p9l/BeGJuAv
         XaeA==
X-Gm-Message-State: ANhLgQ1F1lWsXBaaC6qoU+RYDpvUYVQaE2lQWm0NzuMyqaUdkpzEkCtO
        gqVAOnYDzNh+vW4HrRel2LJHzA==
X-Google-Smtp-Source: ADFU+vt2lLYB0Tgp6XRl+Nd0We086rBZL2iX6nYLI5T5X83Rf+H43VbfRkFbjVqQgqGMEydvpBiXPQ==
X-Received: by 2002:adf:ba48:: with SMTP id t8mr36017493wrg.329.1585047466432;
        Tue, 24 Mar 2020 03:57:46 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id c7sm17274309wrn.49.2020.03.24.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:57:45 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:58:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v7 7/7] mfd: rn5t618: cleanup i2c_device_id
Message-ID: <20200324105835.GJ5477@dell>
References: <20200320081105.12026-1-andreas@kemnade.info>
 <20200320081105.12026-8-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320081105.12026-8-andreas@kemnade.info>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Mar 2020, Andreas Kemnade wrote:

> That list was just empty, so it can be removed if .probe_new
> instead of .probe is used
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Functional independent from the other patches, but since they are
> touching similar areas, commit/merge conflicts would occur.
>  drivers/mfd/rn5t618.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
