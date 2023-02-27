Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960B6A3BC3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Feb 2023 08:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjB0Hhp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Feb 2023 02:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB0Hho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 02:37:44 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BE1B2F0
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 23:37:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h10so3500583ila.11
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhOT+g+3DEn8Sfr6OEJb+6uq9ViAaYHG5g53G3K0p/0=;
        b=eQMRj9z0c9AJZ6T5bHbaxtWtNDHpkAkkcQxrHN9J158OMIsP0HRS5yUzYelF3AdJAk
         dgJ1LU/4juZE7EVrrqoj7wdjwasQOH/GKeKDshAzcmkiagm+uWS7+A3gv/ACfi9Rxrzr
         DurL230qmjdcYKDLhqKjou2vc3CnachPhGKSvkdMDoKPj8jmu6/TnP/QluWyKUW6L4Uv
         +Af7RZQ9WOhNHDht5Wx2bZbIShcVj97phsleQdXGh7VsnIzXqCI6LrDujXpi27vFdkM0
         85uls4L57RjxPqjPGAiP++OomspO+WfZKbNWnw5GXk0/x7xYU2P8Z7KddIO8NdILuR/8
         JycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhOT+g+3DEn8Sfr6OEJb+6uq9ViAaYHG5g53G3K0p/0=;
        b=qu6mGGPujb0QIEPKe1kKeldKiHFAzzP4dIG/VoxIrIkW/db0NdLeioDl/ygpW1KA9Q
         p1YEaQx9E8wZvktDhjhETa1LHfMt4uU+7xRzQ7DE+yIS5mM1s0AZ97O77CBUe5O8GToT
         vGkbOrDvKsWhG92CjEFLHTUZkDmLkqIhop9VcQVPwMHg8mvQkKaEu0lMbQhZ8YuZrlmz
         bCGQRxhjX6Kn3Ttk9JWFnxFh0Lb/PonayxftABGI8XSRYER4fb6EvZWgsSUJHJXDKM9A
         v0vhvkPDq/qq0vbCk3fWClRuuQSfRgsv5BLPkfC5Cy+7iyxLJdwoYy/v2JOhCocCZiOp
         cWCQ==
X-Gm-Message-State: AO0yUKXtw9iSjC1oVQx7WQlMnk+kp27cY2BxUPbjBLacQTEJOkf33RFG
        OaKCe8UiV36y14LJEmP+Kxjwkpip/Y8=
X-Google-Smtp-Source: AK7set8m2Tn6rph8T2BM/X+80iiiqQWhWzhylVpBGHL1IIOqKI8FLXNuI4nwKLDoR3Ooh83Veos5pg==
X-Received: by 2002:a05:6e02:1c22:b0:313:e6ae:3490 with SMTP id m2-20020a056e021c2200b00313e6ae3490mr20932696ilh.14.1677483462731;
        Sun, 26 Feb 2023 23:37:42 -0800 (PST)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id z14-20020a02ceae000000b003afc548c3cdsm1931588jaq.166.2023.02.26.23.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:37:42 -0800 (PST)
Message-ID: <b0e25164a712c816f5dc227b5da21c653c57c4f1.camel@gmail.com>
Subject: Re: [PATCH 3/3] iio: buffer: fix coding style warnings
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 27 Feb 2023 08:39:37 +0100
In-Reply-To: <20230216101452.591805-4-nuno.sa@analog.com>
References: <20230216101452.591805-1-nuno.sa@analog.com>
         <20230216101452.591805-4-nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2023-02-16 at 11:14 +0100, Nuno S=C3=A1 wrote:
> Just cosmetics. No functional change intended...
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-buffer.c | 98 +++++++++++++++-------------=
-
> --
> =C2=A01 file changed, 49 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c
> b/drivers/iio/industrialio-buffer.c
> index 7e7ee307a3f7..e02a4cb3d491 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
>=20

Hi Jonathan,

I noticed this one was left behind but I just waited another week to
see what happened... Is there any special reason for not taking this
one?

- Nuno S=C3=A1

