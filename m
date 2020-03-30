Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5419880E
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgC3XUn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 19:20:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33276 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgC3XUn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 19:20:43 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so17611801ilg.0;
        Mon, 30 Mar 2020 16:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBOl7Iekk96c/AIshrO/3RWqL8uoE2wDrX33YLwOSfA=;
        b=q7x51mgyazH4pO4gnQpexWGV+/MsOQZAnCfQz8ZHoCkCfmgpPWDPS686yh0y8MP/CD
         qKqcFMYfXd+pUv6zouc99BiSZwtaafEBxoYd84CVr19FdZurjOV8RGGXvH6KuM3+pw83
         TcP9/IYfqWPRWUMfqBzdC+TnZbawfSBDORE28iEAimrzKm09NWYw+uWXs0Kt0KRgA3jA
         hwTY3BMn+zl9ZBuYGwTEWDLcd0M9CHN0jIodswYoMFWNWa7v7L4fOpu24VHnPfBYVH6q
         QGO/Bw5VdJSWYyZjajwlPguEOeDefS5H08Z4v3CHyxzGKibc/PuIUds8o6zMvRyWYXNh
         1QzQ==
X-Gm-Message-State: ANhLgQ3fqWsg07qlvXODT2I8FNaw4XBLZI4JU4MDNz+KG1homZl9Ix5X
        ZpFXZW74WMhuF/8rg41eww==
X-Google-Smtp-Source: ADFU+vuWSuZ4f9YO6jw06I9AgPXOM3ftiwikw3P3ryqZHCbuD8iOLBgqAHDz4IGWRDg4StG2CP/baQ==
X-Received: by 2002:a92:91c3:: with SMTP id e64mr6471514ill.68.1585610442647;
        Mon, 30 Mar 2020 16:20:42 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s25sm5336349ilb.37.2020.03.30.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:41 -0700 (PDT)
Received: (nullmailer pid 16658 invoked by uid 1000);
        Mon, 30 Mar 2020 23:20:40 -0000
Date:   Mon, 30 Mar 2020 17:20:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, fabrice.gasnier@st.com,
        olivier.moysan@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: stm32-dac: convert bindings to
 json-schema
Message-ID: <20200330232040.GA16570@bogus>
References: <1584639983-31098-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584639983-31098-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 18:46:23 +0100, Fabrice Gasnier wrote:
> Convert the STM32 DAC binding to DT schema format using json-schema
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Fix id relative path/filename as detected by Rob's bot
> ---
>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  63 ------------
>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  | 110 +++++++++++++++++++++
>  2 files changed, 110 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
