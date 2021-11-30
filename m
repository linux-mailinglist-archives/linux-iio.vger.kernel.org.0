Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54861462FFC
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhK3JtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Nov 2021 04:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhK3JtQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Nov 2021 04:49:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B4BC061574
        for <linux-iio@vger.kernel.org>; Tue, 30 Nov 2021 01:45:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so18847703edq.7
        for <linux-iio@vger.kernel.org>; Tue, 30 Nov 2021 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2iiyK0fX/f3Dg09fAsKa+40KpvFGcilrTu4i7aduLZE=;
        b=quKkmnGSW4z0t4w3kEbPaaMxVgLPttcXKZmYtly8lq0R2SFqkx0LvIze9ffXtgTINU
         Bn2F3nt4Cj6DuQ9Fn0UorU4DCopBXka59FlS1b+vJLyP1wQBcdjocYCkcJLtKQqZHBvj
         5R6deHHl172ie3C14jx1RxuhpAE95EiQcpfSg+BMfU6uLMRYeWCh64NrhGJz+on/RBd3
         yWoyFupShgI+ytKAn8nKhtrAeXBZGbS+q92NFIX7DM21zmxe4EZTh3UymJgRGH60ehTa
         aBeVWe90pG6bsAyO01wOX0M0Q1HXt80SSZfYDzQE4sU4YDKTKLlRYVgvKz0CTzxe2UH2
         Dk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2iiyK0fX/f3Dg09fAsKa+40KpvFGcilrTu4i7aduLZE=;
        b=HZ+Z/eb1DKDEUzkmWEMsRm80FwYTFP8uNX5y9PsiiRW0OV0od8Uw5FeUPUY40+ij4J
         xexPdUJACT6Z1+fGCQp/7UDIMGKhbxcTA1NdYeCMV6q2hPJQ1IVrKbIUkwSwpMuMB5pg
         42HmsyLdiOCNMjHV6HCXsdErhQc9+MPiss/rI2i//ppzGYBk0YyCkUIAvpnW0kWWAyP9
         Yy9V1kyr8HoQ9MOA00Z5IPgMz7tzgYr3G7arD4FAmbrfbJhqZVHIkZ7P6ULdhjGmCBNz
         IChG4ON+jWu0KsY/YakdASpyUmqvjKZ7Cp1vBOgJa9GORurXNU7YoHyAeghJMGRlTp+4
         kOKQ==
X-Gm-Message-State: AOAM530LVUNepdLOG+8lP5qFpHSAUXs8WqxCiP+oBxkIjRpzZJjLxjsF
        /zFSDuB0IpmzurEXybD7u97WjUbcJCtJg4AGZ38DWerFj1iQMQ==
X-Google-Smtp-Source: ABdhPJzbBsP36i2dj2/9byhXE4Bm/BNchaCYMXi/2ZEV8OoMClLeKD7vwB2YRfYd1L3v2KXJ6xzKo7INz8kg2Enw8LE=
X-Received: by 2002:a50:d741:: with SMTP id i1mr81941398edj.37.1638265554378;
 Tue, 30 Nov 2021 01:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20211003162417.427260-1-jic23@kernel.org> <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
 <HK0PR04MB307480DD560E45390BA4F081F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
In-Reply-To: <HK0PR04MB307480DD560E45390BA4F081F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Nov 2021 11:44:17 +0200
Message-ID: <CAHp75VcfcG55FB7uRKozKUnb6ZGQ_v=L71bTND5+5vcjgQaBOg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs
To:     =?UTF-8?B?S3VueWFuZyBGYW4o6IyD5Z2k5o+aKQ==?= <Kunyang_Fan@asus.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        =?UTF-8?B?SmFjb2IgV3Uo5ZCz5paH5YKRKQ==?= <Jacob_Wu@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 30, 2021 at 6:22 AM Kunyang Fan(=E8=8C=83=E5=9D=A4=E6=8F=9A) <K=
unyang_Fan@asus.com> wrote:
>
> Hi Andy,
>
> This patch would affect the ADC function on AAEON x86 products: https://w=
ww.aaeon.com/en/p/developer-board-intel-11th-up-xtreme-i11, we need the ACP=
I ID to enable ADC device ADC081C

AFAIU Jonathan did that patch (and it's applied, right?) exactly for
that reason, but the main issue here is the process inside AAEON
company regarding ACPI IDs, can that be fixed please?

--=20
With Best Regards,
Andy Shevchenko
