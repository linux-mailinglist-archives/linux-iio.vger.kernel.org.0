Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A54E7DF0
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiCZABt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiCZABs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:01:48 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A365C66E
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:00:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 12so9867388oix.12
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XwmOV7wslGBbWKst3lCi6LmAu6bXFmmyozlRIiVMLus=;
        b=kRm4OQ0AZ2GicUnGA1EWJwKr9zTduaZwV37Da//8xwdFmj9xMrL3PwvfHrNZufSThd
         oGtONJ29ljr8MY2TF+Mv1dW7VX0SkxQ5zQ2HpwLPk5TjiK4TH0vDb+0m/UH7Q4fYISSM
         zAVxlheCaRBtkKgbRl1T/cmNxh4WBmflmsAbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XwmOV7wslGBbWKst3lCi6LmAu6bXFmmyozlRIiVMLus=;
        b=3aOFmq0DGBo/Wb0+89ydiWhd1/ZyPqBu4eOxnMHMqwjNfewNGYorLo62kt8xb+fXxn
         JjxIQjA7CS1Od9SOA2l4rf2ZW8ieIdIw24+1t1uv+8dahQwGw+B1NPolSLBcPWJ+MBld
         TN6+DwSsKH1AA5cb1EWmREwy5uhvZWZpEnqwnHOy2q/PqMZQczfk0b2lTGB9Yqb9N5F1
         oCDlBQO5smr/MDK7BrLam+cmJZf+Ok2kYCNaw6vs791+XSI7VioBV5zAMVFXzjAs3NwC
         MKpzDvLwuNqm//fkSrDi7HdtoW+G3iOtvS+egJUXrUnnXhuj4vxHMWC+xhGlk0QBPPMa
         lg+g==
X-Gm-Message-State: AOAM531zwfmE06Vu937U+gtfGR5j9OAYNRgbDBHPaHEtbMgY/hnNKFkB
        BBvKIOxwiqN3FyUWdHfaGgymJjbsa3ejzYnUcoIqEg==
X-Google-Smtp-Source: ABdhPJxESYfHD3mh2m9IopbbIwY2icxa8lcVlrFeTUDB0qdd2eblqsJ/8zdmP+dxsuC7dFOHDC4SFHNzr+unne64PrM=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr6900670oif.63.1648252812719; Fri, 25
 Mar 2022 17:00:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 19:00:12 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-6-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-6-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 19:00:12 -0500
Message-ID: <CAE-0n52HusYW0+KhZZq6cpX0+gF=jPGZsSThqww0wayDEbj6_w@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: sx9324: Add internal
 compensation resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:24)
> Allow setting the internal resistor used for compensation.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
