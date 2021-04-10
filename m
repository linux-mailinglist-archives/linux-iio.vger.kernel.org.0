Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748C735AF0B
	for <lists+linux-iio@lfdr.de>; Sat, 10 Apr 2021 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJQU7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Apr 2021 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJQU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Apr 2021 12:20:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D6C06138A;
        Sat, 10 Apr 2021 09:20:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w8so2820562pfn.9;
        Sat, 10 Apr 2021 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/2OfzzxnxOCDxc5Ilck7Epb5dTCszeXwDU9tJLtUKc=;
        b=JGjbNbMLLzkVqRq62QyonJjoR9WwRVFsF0oyMguSXQy4XNImhjTDh48Nl/hEZczEzu
         Kz9bOAmYqHNTRB9N6V8YLhIdW602GBoWKGG4qC1V17db9B+4Mh7Zv6blRzmEi76Ge2GZ
         y2vgTHxrNa9IAoHeco2Hiz++jezn/5ZRbE5AK5/ylBCVd+UNhxzMdzoqVCn64PquDSJB
         Cp6Jpm/UaMaVvtp/dmbH8u6v5inm2NtjdW0K6m8OaSkf8xb+awZFazVgxVAxjlXZzgn4
         zfYR2TNSd2FdbeGUZh/SB0neBaEfKz5fwcE2CHUuRtdDV6GdV3Ui2TvcXyhbUEPWU1t6
         G0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/2OfzzxnxOCDxc5Ilck7Epb5dTCszeXwDU9tJLtUKc=;
        b=LLGA2W+lF5Bb7ZPKgCnv8oFgAJ9h3Mt1FRdm0uAsdtsP+Rhs5e7xOB7ZIpWR1r69PV
         /o37wPOifJu1oVYPevrz43D+gVDIn0BMW7bahPAsRTUm+DlP5BJMh9OqLgM1l56b0R4w
         PYrjDp63xGsh1pZW/RBhnZp7S/HKT6QM65v2NEV6d9eGlR9tHZXmlPEwrAv/YWyVOSDb
         1oSHRT6qTpgpQw4+gKF1DiSg5ENXbDKhl2thwhpooPTI+H3oRMCnpFblbslZn7LhA7Fr
         ycFhbMAzun2RZjK4VkUR167BKHZvDewOzncJX4s+v4oXdoC++iw0zDEOWEArWyIqn7uT
         AHvQ==
X-Gm-Message-State: AOAM530v62yATwjR0Y1iKeIer/A+L7CqXV2MP/ooVgBUOBgNPrAseauo
        jv368dO1FEzAxiS+b5g4E5RagHo23zZd1OhDtoci0isWf2Q=
X-Google-Smtp-Source: ABdhPJysfXNLMQ7FkAAnDg8NfcshdeP6IElWUUeqtmyMFGwMs/IKB9hx9lW/QzNPk6Aa+7YLaslAjMlPeHInIfaNbFU=
X-Received: by 2002:a65:6645:: with SMTP id z5mr18024871pgv.273.1618071643867;
 Sat, 10 Apr 2021 09:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
In-Reply-To: <cover.1617993776.git.lucas.p.stankus@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 10 Apr 2021 19:20:32 +0300
Message-ID: <CA+U=Dsq7EgSapyCmQfuFr+qyDGc=6wLWOruLrugsJsxbGTyBtg@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: iio: cdc: ad7746: remove platform_data in
 favor of device tree bindings
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 9, 2021 at 9:50 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> This patch series aims to replace the platform_struct for the ad7746 driver
> in favor of device tree bindings, creating the dt-bindings documentation in
> the process.
>
> Since the header file was only used to define the struct and the excitation
> level values, it was possible to remove the file entirely.

From my side: I need to get better at understanding IIO and how to
place some logic of devices into IIO,
I don't know if there is a better approach at converting the current
platform_data into DT/OF.
Maybe Jonathan [or someone else] has some better ideas.
Otherwise the overall approach looks fine from my side.

>
> Lucas Stankus (3):
>   dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
>     AD7746
>   staging: iio: cdc: ad7746: use dt bindings to set the EXCx pins output
>   staging: iio: cdc: ad7746: use dt binding to set the excitation level
>
>  .../bindings/iio/cdc/adi,ad7746.yaml          | 79 +++++++++++++++++++
>  drivers/staging/iio/cdc/ad7746.c              | 43 +++++-----
>  drivers/staging/iio/cdc/ad7746.h              | 28 -------
>  3 files changed, 100 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.h
>
> --
> 2.31.1
>
