Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD24DBA3E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351964AbiCPVkU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358257AbiCPVkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 17:40:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41D53819B
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 14:38:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k25so3919482iok.8
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ni6qEV23bpfC9gZ85rViHqPr1Fe02W50huWIxyNEUM=;
        b=YDoHhjkzfqfaghn9OIA7SaV0d87Xf0IXGRdp5t0bNzOvxtgPauU4faPlIhH0d+HjBY
         qjATOau7I2cTNJjphGROqb3gQ4m4ZF2vXvPZRRoAKX1Ufzs9lt80l571VZE34FI8o1WF
         /dl4B6dB5zSAGy60rVz9BmVZ+JqUZHX+QmzNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ni6qEV23bpfC9gZ85rViHqPr1Fe02W50huWIxyNEUM=;
        b=k3O+TmN9BhHofe4UgrY7p/f7xNjT6qlLrILZ9PKMeHbDg5pJKS0gbikQNkZ4JKtuRl
         Jj2x8uzjkRgsznhha5DPFnvAQkjTKPtRYYtoOtpiLl4XmIHVnVZYktKlU+SCoOlA67Ap
         60RdbUkBqxH3SE6YNWrKNQXpVSY7wktQna2IoPhmwlG4FIvVLECPsoqPfMUH3BUm1qQt
         aJznyPwr8Z4yzQ4Rmm1ynGC9G/fkLiajsEfv09rcal89rTcY/NfGzCNXUS/XYBlUSP2N
         GctzdX0GbQP+7/y0GhSMdlzNK4Ba7Juz/RiaonBUkmcoJtYcEgHbrJPGDqjZx72qhibr
         o5fw==
X-Gm-Message-State: AOAM532gQMQLFomAUOhiIHfnpH7GXwQc1wloHg2DJKjTQCVTIP918AWA
        bUAv17zdFxCoC7U670c6JHXZMZY+fx2QpVCYe356Vw==
X-Google-Smtp-Source: ABdhPJyDNC+rz9Gv3wfYl4tEz5JX5mPK5as58m8jtyXLL2S5aD32zTRUm4SgHmvgoX+uYCux/ML3AEi6m7CLCXhVYGQ=
X-Received: by 2002:a6b:6f0c:0:b0:648:ea2d:41fe with SMTP id
 k12-20020a6b6f0c000000b00648ea2d41femr847996ioc.63.1647466739121; Wed, 16 Mar
 2022 14:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220315173042.1325858-1-gwendal@chromium.org>
 <20220315173042.1325858-2-gwendal@chromium.org> <CAE-0n51+Vyco+drQzF79bE06_UTKHHc3J5Q1wMvxEntqEBpyug@mail.gmail.com>
In-Reply-To: <CAE-0n51+Vyco+drQzF79bE06_UTKHHc3J5Q1wMvxEntqEBpyug@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 16 Mar 2022 14:38:48 -0700
Message-ID: <CAPUE2uuRG-aQ1_bHxJts+5bsGeZDrFXqCOfoFXPTdCyfv7CwKA@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: sx9324: Fix register field spelling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 15, 2022 at 11:19 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2022-03-15 10:30:36)
> > Field for PROX_CTRL4 should contain PROX_CTRL4.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Any Fixes tag? It's a typo though so not really a big deal.
Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
