Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1F5BA692
	for <lists+linux-iio@lfdr.de>; Fri, 16 Sep 2022 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIPGER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Sep 2022 02:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIPGEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2022 02:04:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2793923F7
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 23:04:15 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id m81so3309573oia.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 23:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=8BdkLw0uWO4U87+rl944ndZh8X6D0QGOOjYYvlX1HeE=;
        b=l8ERW7n3OgRdcQb0sgpPr/+z5l15tk8svsjwDOCJ+sugMIhVnEK9VCVai03SDHH8M7
         Sirupn154QmNL+SeqjPrCGEwoHUj+ef3LzwJ5TW3zSbUGTN/3rCh+DTAsOVB/tKWifBy
         uISFRksUGqrI3vWTH0xvCUhQZBjK02VnA7dI/eQjxPEMRZaW8bEeQ8HrjcfXInOGzmgD
         UA2o9mBic+K3i0uBzNRkqSldRUaaGTwAdvkH50Uu30zyrnT9epTtnnLBfzliJoYUwwK0
         7irBvXDmjJw94dYhx8W6NeLNkZLRC/iB9uD/n6yJFu878OFo6ff0cZhZ9BGi39lSWCey
         l5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=8BdkLw0uWO4U87+rl944ndZh8X6D0QGOOjYYvlX1HeE=;
        b=HfIg89u78vSD8202Wbj+bCY4m3gqYSvmtq8Qcu6pteVevSFaNSI3jHRdC4AtvBrrFy
         LXLM5/Lh3xjWdi8ZMPf07jVTCuUyOMlm6YmIGoYLjXKA9dDNceeYuZL6Ehi0SSPa2dsx
         xgO7Q5v9S+ndCvkP52RX4aikJ0D90WBge5rYQwLjH/xv2FVte2TinPDuUvY4hGuqzQt0
         B0nybHlXw6jxf+yO9iTUhFYfZOoywhjI87qLI2+5RBNTI4at9ToCdLvMAAQTljxmiccO
         kOkz9Nu6u9RzV3OoaFM4N6qPQAFFTtZ7mmAarMpspOTj4sSpGkgi1UA1B4Uhdavspcs/
         ENbQ==
X-Gm-Message-State: ACgBeo2/zaXnv/FmgJk8tXa/q1ySOeDvpMkvzjIc99+5R1aU7Wozl0kT
        6jjAmy6C8Q0xJDACU4Gkz98=
X-Google-Smtp-Source: AA6agR4wicLg2+yOsyxF2pWQDEdWbvBjRLDPZ6q9keyFPbuO1Igvbn5MSUBS8s2ROpQJ1dcfh4sSWg==
X-Received: by 2002:aca:1018:0:b0:34d:8f7a:27e1 with SMTP id 24-20020aca1018000000b0034d8f7a27e1mr6041814oiq.284.1663308255160;
        Thu, 15 Sep 2022 23:04:15 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id l4-20020a9d4c04000000b0065126423321sm8251030otf.76.2022.09.15.23.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:04:14 -0700 (PDT)
Message-ID: <d3d6ee8fdbbcf78a4b8b7f93bc8a417c811be18a.camel@gmail.com>
Subject: Re: [PATCH 0/2] ad5593r fix read protocol
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 16 Sep 2022 08:05:29 +0200
In-Reply-To: <20220915153836.7f8ef80e@jic23-huawei>
References: <20220913073413.140475-1-nuno.sa@analog.com>
         <20220915153836.7f8ef80e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
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

On Thu, 2022-09-15 at 15:38 +0100, Jonathan Cameron wrote:
> On Tue, 13 Sep 2022 09:34:11 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > This patchset fixes the read protocol since it needs a STOP
> > condition
> > between address write and data read.
> >=20
> > The second change is trivial and only adds an i2c functionality
> > check.
>=20
> Given we are late in the cycle, I've queued this up for the next
> merge
> window, with a stable tag for the first paatch so it'll get
> backported
> after the merge window.
>=20
>=20

Alright. BTW, not sure If I already asked this but do you have any
preference with regards to CCing stable? Should I have done it when
submitting or do you prefer to handle it yourself?

- Nuno S=C3=A1


