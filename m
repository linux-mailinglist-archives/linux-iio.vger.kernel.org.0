Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B94E7D55
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiCZAAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 20:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCZAAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:00:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389B5DE6F
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:58:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso6633450ots.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oEAPu3kqCzPDjpRiQu2QoVcgItEi89b8UR0caW9U3wU=;
        b=Am1W1DHZZhYTDDy6mSDmjkUPTRQgeyAyRDXHuhMK3OOx+b7KFsW6JK5moXcHcMo+1T
         Ad60xUl4KDdchvVSSjG5Jk0xT1CRvmgVPbF/VSMdir2JV0M2IfvzDYsPLMIcOts7XMG5
         Rqi+GG6fWhyu5zCfn9O7YtYzQwQyt20ZKBzkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oEAPu3kqCzPDjpRiQu2QoVcgItEi89b8UR0caW9U3wU=;
        b=PBDv7607ElrhAxtdapHUV7dAJ1I9qvksBFnZTA1dt4v62Z3/eTErXe8QCGeA5NQNUE
         sPw1M6hZ51l0/xqks2V8gcKzLmcDLUGIZjMtdU4De9I2biCVh7ISQdkvdyPwomXBXl9h
         N9A86UCxFLpDMJJsa/bSzJXkRy8eCj9H9r2a2jm42XyofSyF1TALPGKLzXToNXJVlUlf
         A+PKdGHJgnXaUeURPrBKAEkfT51j0iTfc2cmm0aMSv+4stQRfCCIm8oo6JYVgxt1/+Tc
         XDIn/vHewfakiqQm1kRSXjJXT2ZWChQtivz7KqU/OVj9C6N5VOQw45Wyg3PxfFdEZdfU
         nCrg==
X-Gm-Message-State: AOAM533ilmYNniXXV88uCQMiMQpxeQeXEo68WEyj6ebtxuL/csCBPKPu
        M7OJGaWv+PQFkF0fTzUqnv+msk2PcYC3Lsi7Zjc+zA==
X-Google-Smtp-Source: ABdhPJx2hcI5xF7G4bZWFQCj7Q9C0/U3BwzIq5515vfjYuVQ4Fe2FoMtK9M83R6v/iIkAYSxyv96Qg2U4zi1c/HYnT4=
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id
 w27-20020a056830061b00b005cc0e447dc3mr5543161oti.159.1648252706040; Fri, 25
 Mar 2022 16:58:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 18:58:25 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-4-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-4-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 18:58:25 -0500
Message-ID: <CAE-0n52fTj5-EKx2wF6ZO58S1ooaDPfnygyWH3+Z7ZG-txt4Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] dt-bindings: iio: sx9324: Add precharge resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:22)
> Allow configure the resistance used during precharge.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
