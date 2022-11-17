Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56462E251
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKQQyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 11:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiKQQyk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 11:54:40 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4C11A;
        Thu, 17 Nov 2022 08:54:40 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so1410827otg.6;
        Thu, 17 Nov 2022 08:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky4noUBAiLuJn2jNr/peuFv40T77tPcI0vV08pop9js=;
        b=eR8PDaHtk30bcaOvWoV0jjzpqp3vCXA+2nR8fjWvA6Dyrf5viPsawQ358pOP2eHn+S
         hXn8k9MUf3WCrODi+ixs9RAdXh0HTZ/eml53urvVDj6lK9jmztgy5VLhwCzwxRZW/AnI
         zZcSaO6hkursIvoR/5MYhYJk6DFfzZbA60+NfKkRICI3wMf7DlA0q6jg1CQ2YONRWNMZ
         HbmciLF3jfCOD8m0yD67KxANrdfWMiC86mPZmgn82HExzwEozv77QzpLlTNEDvKmgAay
         N2KiiROle3zi3DB3c28V4iRToqCmkFjgl+oaTqV+oE8KKT8FQtJGmylPgoiJdvAdsMDj
         007Q==
X-Gm-Message-State: ANoB5pnmwuNiBQ3mnY+xEJlNTi3zJgF2Ph7jwTVdR7NQT2XuvxzYB3OF
        SRSOKojvnsjRWM1A0wagOg==
X-Google-Smtp-Source: AA0mqf4mPUDSnvQKvhPu99TQVR+UZJGCWBV/qagCJ+8uH6O/+NOQYFygfgigr4LiPpIuo+DlrnZlHA==
X-Received: by 2002:a05:6830:6486:b0:661:170:49fc with SMTP id ck6-20020a056830648600b00661017049fcmr1901263otb.144.1668704079451;
        Thu, 17 Nov 2022 08:54:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a4ad182000000b0049f3f5afcbasm499765oor.13.2022.11.17.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:54:38 -0800 (PST)
Received: (nullmailer pid 3020774 invoked by uid 1000);
        Thu, 17 Nov 2022 16:54:41 -0000
Date:   Thu, 17 Nov 2022 10:54:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, lorenzo.bianconi@redhat.com, jic23@kernel.org,
        mario.tesi@st.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is
Message-ID: <166870406026.3020222.17685365864951091557.robh@kernel.org>
References: <cover.1668605631.git.lorenzo@kernel.org>
 <55b15b3e8453a12edcf8195ef9c9243a76f87096.1668605631.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b15b3e8453a12edcf8195ef9c9243a76f87096.1668605631.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Wed, 16 Nov 2022 14:40:04 +0100, Lorenzo Bianconi wrote:
> Add device bindings for lsm6dso16is IMU sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
