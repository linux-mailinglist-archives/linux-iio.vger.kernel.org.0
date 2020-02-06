Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC0154D2C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 21:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBFUpz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 15:45:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33541 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBFUpy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 15:45:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so657690pjs.0;
        Thu, 06 Feb 2020 12:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7t1ZBW9g5wlG8KTvc0XcPIxcORXLml7TZ0TKspaLkvA=;
        b=q9OA4932fRBBs/TsXt8q30lSQBD94V7DjTuiiQ4m32bl5QoZWafJnWMWf3QMEdsL1Q
         ZbLiCNdH5CdZZ63jYFYH/DKc9ccoiRXclM0FCcXeysoyqqpkdZMKINb6J0uFbPYrKjHe
         Kk8LV19TSdiToraMiMZjzlpu5cHVs7vuJ9eYu0xY5TEIW/eVKpFNjLTW94YvJqlPIsmx
         z2YcNG12yn3uN+4mNqwZ//rsor7Hwt1Scsl10y7wfHODUY3MormEqBgQr8mLhS73pq6N
         rwiR7Qd/jwr188MdJq8jcEtOxtt5K9l3cZ4fP0lmS6HhNZSAqfeLX2OEJSieYEnfqCAT
         K+zQ==
X-Gm-Message-State: APjAAAWc3CicG1y2zXusH8H5z8GkaTkazpjrDa4HFqO/UxJHbRNcyEgs
        IAV4L2uur5sSWEPWuQT2dg==
X-Google-Smtp-Source: APXvYqzHq35xMKGzxw/a8MEVmjvvcJB0PiyrMJ12ZZgUVekYH3aTlmRKhxb8cjo4/eurccisZ8lRXw==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr6093219plm.328.1581021953661;
        Thu, 06 Feb 2020 12:45:53 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id z10sm275754pgz.88.2020.02.06.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:53 -0800 (PST)
Received: (nullmailer pid 15150 invoked by uid 1000);
        Thu, 06 Feb 2020 19:08:40 -0000
Date:   Thu, 6 Feb 2020 19:08:40 +0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, olivier.moysan@st.com,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: sd modulator: add vref support
Message-ID: <20200206190840.GA15088@bogus>
References: <20200204101008.11411-1-olivier.moysan@st.com>
 <20200204101008.11411-2-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204101008.11411-2-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Feb 2020 11:10:05 +0100, Olivier Moysan wrote:
> Add vref supply support to sigma delta modulator.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
