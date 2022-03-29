Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70E4EB4B0
	for <lists+linux-iio@lfdr.de>; Tue, 29 Mar 2022 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiC2U1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiC2U1Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 16:27:16 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6E93189
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 13:25:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso13526719otf.12
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SFrq+HkhY8EOOEHs10edXecMcSZIs6/OF4q1ev8rVPs=;
        b=ZXBiMuTCpQ95TzEDmK8L4ho9oCJZxa3gxbUmjHjcUOMxq5dmZfs5TpoLjnQuwQ80FF
         2QcUThWMORa98tz4xapDW4dUoPODp9zFLDZ7MrFvb4YTfttQ59Wzmr9reE/caETJokIu
         6jpSgmpt5IqfH7lZvEK8vTfhnfeDmn/WyKxXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SFrq+HkhY8EOOEHs10edXecMcSZIs6/OF4q1ev8rVPs=;
        b=7yzf00HKeFfW2gIQlb4/qg0zXwVuVzpMBMf0F+leQdEk+zD3WTdYE1RNh45lnz4xoC
         Hqln8dxO32kFLipEgFp8kSzwtGhkCAvlZZoqNkYavVnltclcT/K7W0tBU1A5QCnIt72z
         8xUXQSl/CISYox3Ec7Nz1v1bwwsb84+ghwsbcgHYEnAmjJsjhTD00snG+qq3JPd2O1QK
         bzF+dNA+VcgkxhT+95AZHhF9ai6KBO/hQvuH1TOB98cb/KA8ewyrqsB9cdRUqPSPI2+Z
         AXVOTkWXdXJe3f0N4P0kHOPbbSxK3JEC7drPTv0IhcJTibzs+NqMDM1FWECuNQA1Ryk5
         mBRQ==
X-Gm-Message-State: AOAM530lPp0u5Dd9G0NNSzbqWxG8OQz4nZdwU1Rnx4CaQgSzde3pihxN
        gl288D5O1MkrU3A2iG/g8CVG3+rMGc8IIrvp5//ePg==
X-Google-Smtp-Source: ABdhPJwFap4yUqGDUQMinigojaLdGmmnd2GrXlRfBs04gEvioesOAE3NzyeFCZ3fpthNyz+tBYNsGF5TzhbGRtExpZU=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr1918913oth.77.1648585531687; Tue, 29 Mar
 2022 13:25:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Mar 2022 22:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <20220327155147.52e898b4@jic23-huawei>
References: <20220324222928.874522-1-swboyd@chromium.org> <20220327155147.52e898b4@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Mar 2022 22:25:31 +0200
Message-ID: <CAE-0n50T9uqcB9EK-RnGXPGhd6RWdrsE9pA5FJY9yC58xd=05A@mail.gmail.com>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2022-03-27 07:51:47)
> On Thu, 24 Mar 2022 15:29:28 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > There are four possible gain values according to 'sx9324_gain_vals[]':
> >
> >       1, 2, 4, and 8
> >
> > The values are off by one when writing and reading the register. The
> > bits should be set according to this equation:
> >
> >       ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > in the register field, etc
>
> Example seems wrong...
>
> ilog2(8) + 1 = 3 + 1 = 0x4
> ilog2(4) + 1 = 2 + 1 = 0x3
> ilog2(2) + 1 = 1 + 1 = 0x2
> ilog2(1) + 1 = 0 + 1 = 0x1
>                        0x0 reserved.
>
> or have I misunderstood?

Nope. I hit the wrong key but your table is correct. Can you fix it when
applying?
