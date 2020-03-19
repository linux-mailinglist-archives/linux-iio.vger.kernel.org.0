Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B385F18BDB4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCSRMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:12:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37388 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgCSRMf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 13:12:35 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so3074785iod.4;
        Thu, 19 Mar 2020 10:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uRh6l5+Das1Y3n6fQwU4j/xxpeTRicxLD15NbO6tg0=;
        b=lO9NN2l2qQtPjw3nmqKvOrit4Pp4XqcXzo+hIBDYOk7gqX3C9kDy/N6hB9ZUw3L9rK
         zc6R12Wo1hJt7+W5EzJx5Z1Ojm20YVA0fmYtSKamqhiSMB+CmeSYhq2zs80yAsoxjmuC
         KH0xZNyc+sO/3ofh2ku43799H3IMLIJlw9Gi0dneGGMryXv3iuZdXn1NYuRt1QnK9rU6
         +Ruw4GpHV8WZCKuMioL6uGFGY1aFyDgGyP67JfQpE38TCKCJjotWOSqzsAJ3Tt7DmwXA
         717FXY6I+6WCHcnZGuBK9kCCq4dRbSfIqBgGWqoDxJjWrA/ZMTRGDtU2uI6dRcNOrZ4V
         yFog==
X-Gm-Message-State: ANhLgQ3pzlbyUmr8FdYMiiXjcGN32MG9rNjohN0d21vvPBAVfNEBt/0o
        VgLVRL8bdpYePhAgOBkuqA==
X-Google-Smtp-Source: ADFU+vuKqzfgjxCKo37tHMP37T6SVQAWNqhv2cJ1n9k92m0g5Fa3b4S8sTBFsnX2NLnRpxQf1jtqMg==
X-Received: by 2002:a02:bb09:: with SMTP id y9mr4239389jan.33.1584637954714;
        Thu, 19 Mar 2020 10:12:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h29sm1064995ili.19.2020.03.19.10.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:12:34 -0700 (PDT)
Received: (nullmailer pid 17676 invoked by uid 1000);
        Thu, 19 Mar 2020 17:12:31 -0000
Date:   Thu, 19 Mar 2020 11:12:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, fabrice.gasnier@st.com,
        olivier.moysan@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: stm32-dac: convert bindings to
 json-schema
Message-ID: <20200319171231.GA17071@bogus>
References: <1584543037-32095-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584543037-32095-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 15:50:37 +0100, Fabrice Gasnier wrote:
> Convert the STM32 DAC binding to DT schema format using json-schema
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  63 ------------
>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  | 110 +++++++++++++++++++++
>  2 files changed, 110 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/dac/st,stm32-dac.yaml#

See https://patchwork.ozlabs.org/patch/1257568
Please check and re-submit.
