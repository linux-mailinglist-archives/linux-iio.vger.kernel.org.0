Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F607B59D8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Oct 2023 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJBR6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Oct 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjJBR6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Oct 2023 13:58:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77BC90
        for <linux-iio@vger.kernel.org>; Mon,  2 Oct 2023 10:58:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-27758be8a07so47330a91.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Oct 2023 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1696269510; x=1696874310; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=USKYQuL0ssRIZCXry55OgQAc3k9+pcQrxUVPXfc364FBtfDsYJSHRmwu+v4PfSi1B9
         zbmYHPxYMxdXazfhCCQa5nljdNbJlqMWb4eOwPXyJjWXDq/M5X2UxZ81EX0J2UpO4RT3
         K1shePhBQzHcSzPSTsU1eMOrYnz1kcmBtqaPHOXqmQB2nsAfd1aSZ4S9kUvTAhatXKTE
         p/P9M2eky7sDaLdPTsgWQEF4iAyTrWaZ6e6r1MGNMrBP1GFUKLeMGFI30r3mWa4Ea05k
         ejLUF7BBUxRHBKD14l3Tt3jBsA274AtZ1moQ3k1///kwdwNa3+KMJvZ3ZslUlxybUPsN
         QDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269510; x=1696874310;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=j0ADq5i8rBiW+TsAJc6Zh4XUnf7gChGLM1ASdITr+zKSQwSWQaqToap+YqIYW5djjX
         zQTgH/GVddpY50qTm3tuxbb5wOtdKHmIQ7rW4rfLTjbkGqxSwUT4X5B+ltkzBavtzO3Q
         fVEbqmGeLCawxn91+7IywphFx+TKx4sk88iiwwJ2VTnKiEEra7XpyvcKFMjiCbHblCZn
         sJhVo9d07tPVG9sjR2eaxIwoK5ZLuLS6tyJxeczEd8kpEl49iwq9eqZvm5N/LmIRP/K2
         ek2CFnkRiMQ9nEYARLTLP3knvwtXZe+0oMPRJ0VZTYNeKAMAkceGYwNPMrGA4VYexSzp
         yzUA==
X-Gm-Message-State: AOJu0YzzhYMY4eiPybgaihsA5XfM4A0pPHPyWNp9TTI9zKq83+/upkOu
        64T6RmY5HcyeqOyxI2ZvbboN9FWQU7konou4DWUcJg==
X-Google-Smtp-Source: AGHT+IGQHjMRZAb7D3/nVzd2/AuO/u/pLs7STuLvMMyCNUSMsKelOauEJxObp6KbnPAWTkuafrQAIqw86pMbVxu6h2k=
X-Received: by 2002:a17:90b:3a85:b0:278:faf8:af9f with SMTP id
 om5-20020a17090b3a8500b00278faf8af9fmr11357020pjb.20.1696269510187; Mon, 02
 Oct 2023 10:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMh3ZMKYnXqAKMHMafqrwYMvNF+vD+Y6GrDNJinYQnAm=e3_Gw@mail.gmail.com>
In-Reply-To: <CAMh3ZMKYnXqAKMHMafqrwYMvNF+vD+Y6GrDNJinYQnAm=e3_Gw@mail.gmail.com>
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 2 Oct 2023 12:58:18 -0500
Message-ID: <CAMh3ZM+8k1J2VKOmeaVVXz6+PJn3fkHbbXxd4fej5yjenVmuRQ@mail.gmail.com>
Subject: Re: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

How you=E2=80=99re doing today? Did you have the chance to review my previo=
us
email with the follow up below request, I am wondering if it actually
reached you.

Kindly let me know your interest on this

Thanks and waiting for your response.

Kind Regards,
Sofia Gonzales
Marketing Coordinator

On Mon, 25 Sept 2023 at 10:14, Sofia Gonzales <sofia@happybizdata.com> wrot=
e:
>
> Hi,
>
> Would you be interested in acquiring the Healthcare Information and
> Management Systems Society Email List?
>
> Number of Contacts: 45,486
> Cost: $1,918
>
> Interested? Email me back; I would love to provide more information on th=
e list.
>
> Kind Regards,
> Sofia Gonzales
> Marketing Coordinator
