Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A14F7358
	for <lists+linux-iio@lfdr.de>; Thu,  7 Apr 2022 05:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiDGDZp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiDGDZp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 23:25:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F1BC9E
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 20:23:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d10so4932164edj.0
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 20:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VlzCigy76xYUM7Sr4dfFx1Uvh5TMtepSHk9Ek/p6vuA=;
        b=yV4/Kmxo3T9D2npxcxJTZscyzBw9RGEl17wd7RxJfa6XnmWiXFmwjMXpdbCoi/N431
         /2sOo8b3eY9FkC6Nx5tFbHRP8RWPVNAhuWauZOIUbi2AH36iiRX8bTnEVHNFpLXGCvoX
         kH5wq8Zuir9Czad69c9TxaO8Ik1WV/mxKZ7M27JgQG5c1IPFhZnOmgfy7su+f+bgetcF
         yB0XBkCeA3f/QlEOd4JiCvbfTnF1P1Razk0eUi+Rl4tQFPbadwFGDhY09lSVX85hYOQl
         SKJfu0RedQZR96XlDdLI+XwYsXDC8XZdA9iKO3gaCGCAwtfyXudnemmeF0UtJmzA+/Fo
         TLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VlzCigy76xYUM7Sr4dfFx1Uvh5TMtepSHk9Ek/p6vuA=;
        b=g33MdZaY5Iql9a47xxWOljXtmQNkgoUaMKs7SPLXH9gggWeClUr7N3SRTr2h1bEfnE
         1ug/Hv9ZAiv40Bp3xec3WtEvWpS5cmuXJsj5OHtRkOTRyDyMBtlehsjrZKd2pWyhfXxk
         U08ASqw22gIPV80vBbUwjk2Ic4B4o8m7Q5xjHrCh8p54UjiQ3HdRkldcy+4pjKIh1Pto
         cowKh+nFsWd5xWz7d3Z/6l8xwIz63Ub5R3V4C80xSvtak88Yu1AoeaStMpmmUe27gm8j
         g1h2KHQ8de9W5Hh+28+JBGPoeJMWab/VOmISemI0OIfaj1rvkHHwTC/hknMLMuPmRNvt
         QZqA==
X-Gm-Message-State: AOAM533uGkTN3vNQEN0eSnItCO0IUS/BDFBnDo7ULVdydQ97MBWlG6mc
        G+EgLU+QORMdGwVuQVIOosUesacX0KHXjBzw41W/2kKc2yU35xG3eys=
X-Google-Smtp-Source: ABdhPJz3uh9z0f+PP23DEQKm6FZyh+8cmlGBP+MVJmeDrhCVMGHSnoZYYpxsss+6CdI83/iAhlGEfouAC7/212nqtd0=
X-Received: by 2002:a05:6402:5201:b0:419:4c82:8f11 with SMTP id
 s1-20020a056402520100b004194c828f11mr11805292edd.133.1649301820899; Wed, 06
 Apr 2022 20:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Thu, 7 Apr 2022 00:23:29 -0300
Message-ID: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
Subject: GSoC Proposal 2022
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone, I am Ma=C3=ADra Canal an undergrad student at the University
of S=C3=A3o Paulo, Brazil, pursuing
computer engineering. I wish to participate in the GSoC 2021 as a part
of the Linux Foundation, IIO Project.

I have been contributing to the Linux kernel for a couple of months
and have more than 20
accepted patches in a couple of subsystems.

I started looking through the catalog of Analog Devices Inc. and I'm
pretty interested in writing a driver for gyroscopes, inertial
measurement units (IMUs), magnetometers, pressure sensors, proximity
sensors, or temperature sensors. But, while looking through the
catalog, I could not figure out a sensor that would be relevant to
Linux Kernel. I mean, I would like to work on a sensor that would be
relevant to the community and to Analog Devices Inc.

In that sense, I would like to know if anyone in the IIO community
could recommend a sensor that would make sense for the company and the
IIO community. Any suggestion is appreciated!

Sincerely,
Ma=C3=ADra Canal
