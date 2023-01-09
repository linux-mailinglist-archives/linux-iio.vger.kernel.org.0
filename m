Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADB662A5B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjAIPox (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjAIPoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 10:44:22 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDE58FAF
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 07:42:13 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id z128so2151230vsb.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2023 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxk2zFZKr0klIqm4HQNksxkVjPwqY5q0xM28GRiMo+o=;
        b=BLEEAggmxLj1PPrdNuO9szbSbdDvR4BLrEQCaJ0QS9RNn9zVLLmr5BiI+WmG9vZDY1
         KjbwPpkoYAN1YuZuzDSZKXmQJFU7kd+rcXP/9fNNYIUtNKKSx4/y9DFfXiSgjk2H8npF
         re2NXHtwmpCGRzC/SBVj9yaGqRHH1xsRR9k9NmZmNxtdRTC67AeAQ88FHVgUAsBZ9EEz
         UP/ShpPRWFR6nm/6oPhUzTyRoRpnBtCTyUNnAZXHiTj+utAZVPrFegDyC77PMMtXMJCb
         sER6obmz0xVvIfQJhj248ZudSbkijq+3bjbvaKN8+j6iYJo+gzJ0RlxVGuJa+hDKDO45
         7GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yxk2zFZKr0klIqm4HQNksxkVjPwqY5q0xM28GRiMo+o=;
        b=k4u4vUsgD3RuuhWHbu2CJX/2TpuBYBg/XIPAvrr48mOWMsMnqgtbn7rvhsjGeMhmvk
         n531T09AZ9oL2iW7Dg9BK1u2FEiX9CxgslUqj4ULuov5200XISWy+33fQQiSRlTtEq0Z
         2nbeeaxOdYWtwkYKODknCGJCua3IH73GTNzTjTxM+3oO9MzK8zPSU6fz7dBCzOWNMQE6
         7shIghEYYvWYpXHn2C/wOUoi+yDvgdYak6D2P4b2wfxSldQPtgtNjidwFJFtv/XapQSg
         X0pkz5LJjSjsb/LjvkolXV6hc0KtNsdW5sVL00C1+PkuecfSQZHpdaU5xQ6oIgbDAKbc
         FRHg==
X-Gm-Message-State: AFqh2kp9eQ/pJ8HB7OH11T64D5i7C17T0+OWPkkyccexYXYmb08SUorM
        UeRiaq0aXSW1wCjIzOzyt4Eo3gibcn+h5XlANSk=
X-Google-Smtp-Source: AMrXdXvUlCrBOAB6Lv703zqzOG3spYGTkN5Wo/IvTl+V7LCs0eGB2/o3EpDilVYlMzJSbs0rL2gZaEBacAl8wMZAR0o=
X-Received: by 2002:a05:6102:570f:b0:3cb:8fdb:d7d6 with SMTP id
 dg15-20020a056102570f00b003cb8fdbd7d6mr5520820vsb.31.1673278932282; Mon, 09
 Jan 2023 07:42:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei> <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
In-Reply-To: <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Mon, 9 Jan 2023 07:42:01 -0800
Message-ID: <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com>
Subject: Re: BMI0160/260 conflicts
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 9, 2023 at 3:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > On Sat, 7 Jan 2023 19:51:59 -0800
> > Derek John Clark <derekjohn.clark@gmail.com> wrote:
>
> ...
>
> > > Remediation:
> > > I have reached out to the aforementioned companies about releasing
> > > updated BIOS for each of the respective models to correct the DSDT
> > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > BIOS for testing.
> >
> > Great.  Hopefully that means that the scope of problem devices from
> > these manufacturers is not going to grow too much going forwards!
>
> Wow, you have Ayaneo response?! Unbelievable!
> If they answering to you, can you ping them on [1] please?
>
> [1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/
>
> --
> With Best Regards,
> Andy Shevchenko

I've been knocking on this door for a few months now. They recently
sent me a test BIOS with the alleged fix for testing. Hopefully they
do a wide release once it is fully validated.
