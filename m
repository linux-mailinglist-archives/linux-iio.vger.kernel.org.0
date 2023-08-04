Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFED77073F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHDRfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHDRfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 13:35:14 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF94ED7
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 10:35:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34928e9f24bso8505495ab.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Aug 2023 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691170504; x=1691775304;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oujJ+4x9Jqnc7az44sLEMX7bXrpiZXX5ckxrG5n/tHo=;
        b=d2CwLfk1vQ4vS1ViB/M97N6Payx5hyQz4XbSAlyQ0C0Wxv1zkJvljAk74bgRr2XnQ9
         YuXbwV+OkflxOZMyXybjehNXWsJpb0hGPh3ehG7eXAbx7g6dBkHkyoZcf9AMA6T1BSzD
         NlCxU47cmtbX1fWryNp54pEEQVAtAdIC2hG9USTYmJawT2rEXfHfKq/8kICvSjLi9Xls
         Rru1heOR5CMeoB0hr/ECNDMMQh0plgB/C1H/aEKKgqtD3iW6dkcLGI0hgZbFc2/exfLi
         /WItGsK6KopRMQX3LHJTJfTe8i2bv5hiD/QvlxVTfkmmR2WyPd5O65VZWK0Hb4OBwr6v
         oGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170504; x=1691775304;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oujJ+4x9Jqnc7az44sLEMX7bXrpiZXX5ckxrG5n/tHo=;
        b=Js9KjJgyOZy49+qmrsuwgJkVqCmfsRnrfRQ3kuzABJ3Ucr+Z/74WdFkqrkGqZme6pu
         lrL3kGqNT00HBjpJoOc8FU74mRhCoXFELxTuKM+NpsvGqPlxT8eZKl2wk1OM2MrAoEp3
         V3mX4amuf/oFAzCBhIniWD91gdFTZlskbcM1XDIb+t8ZFzXPC07b0ExAEt081+b3d1cn
         uwwWpfNrv3Jyq4f92f7/aQ7Ro2Zug2rAlNOV7xcRl9GdmY6KW/5WY+Jme+525JysoWZU
         26aHjcRHhtSspW7UDaBTWXwbqMvqCL9d0Q2EBA2nfXCnYTT/QmLO/oDwgxN1UjE2+3AC
         r0Bg==
X-Gm-Message-State: AOJu0YxPN2uYO9ZUVL4aPE84/1oTYUnBy0kAWHj9q07JPIoDXqwqJc7a
        1Z+H8Ig8baz/VDBUJoM1RgpOTLP11paMNymVq9jRwJ3OIaM=
X-Google-Smtp-Source: AGHT+IG/8P/6gNEIUk0nNvaJnhFQyLsLIvTL8MRhN2gvGaTqZy3UJDsfel1eDLKgdzTkLPJGmF5fOXnLnLrRaBMGUGc=
X-Received: by 2002:a05:6e02:164d:b0:348:8ebc:f759 with SMTP id
 v13-20020a056e02164d00b003488ebcf759mr3949350ilu.6.1691170504223; Fri, 04 Aug
 2023 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKaHzc88pv3XtAR8gWJYQqu=KJJ4mrVgbKU2ASmvbj2u==ZtYw@mail.gmail.com>
In-Reply-To: <CAKaHzc88pv3XtAR8gWJYQqu=KJJ4mrVgbKU2ASmvbj2u==ZtYw@mail.gmail.com>
From:   robin getz <rgetz503@gmail.com>
Date:   Fri, 4 Aug 2023 13:34:53 -0400
Message-ID: <CAKaHzc_2E42oFZVA=Y_K=Zds7U32vayu7n7fkd0qsw6M3gzk-w@mail.gmail.com>
Subject: Re: Libiio v0.25 release candidate available
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-rc2 was released today.

https://github.com/analogdevicesinc/libiio/releases/tag/v0.25-rc.2

- fixes/improvements for Windows IPv6 handling
- fixes in iiod (to print out IP connections)

Please try it out, and let us know if you see any issues.

On Fri, Jul 28, 2023 at 9:54=E2=80=AFAM robin getz <rgetz503@gmail.com> wro=
te:
>
> Celebrating 9 years of libiio, the userspace Library for interfacing
> with Linux IIO devices (libiio)  is getting ready for a new release:
> https://github.com/analogdevicesinc/libiio/releases/tag/v0.25-rc.1
>
> Improvements:
>  - improved (proper) handling for IPv6 link-local addresses
> - added binaries and fixed a few macOS-13 arm64 issues
> - have iiod shutdown, and reload IIO context when getting USR1 signal
> - added bindings for C++11
> - added some missing man pages
> - fixed builds for SPARC
> - and many more
>
> If you find anything, please report to:
> https://github.com/analogdevicesinc/libiio/issues
>
> This is likely (hopefully) the last release before an upgrade to
> libiio 1.0, so we would like to make sure it's as stable as possible,
> as most future effort will be spent on the 1.x branch.
>
> -Robin
