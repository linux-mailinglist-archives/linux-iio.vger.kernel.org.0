Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46C377EFF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfG1KH6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 06:07:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35695 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfG1KH6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jul 2019 06:07:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so39942669lfa.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jul 2019 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PdnB4+DVETsuhtxt6ZrOFlXGwuc4dLlLuSMGN0xrw8=;
        b=SBZAHqGUVpiWTwyGhjgib6Ba8GdoI75a+L56oQjr43fm4qV2BFxftfLsMlqrqFn+EZ
         5mdVWAT+B+VByU2CkAVFlJxxvpHFN2tm/Cpiyr9ulZVBOMGyg4Mud8P9Q1qJhxDA5erJ
         ESRpyTBSFLBBgNZ8EmdPLcw7TcmuZ5dWXuz3D3WsZtikm9kKl6/8RjhBaq1cCXWLwNJC
         0oeXcRF5K2vATaK9Ugac2PfqhBrPYXrWIHUet/CE+Vr5nKOkPJa6boOi9BLeiUzq1aHR
         kRgfRj8FD4OEp9TxabCKtDhHabREwEel8ghVMku29geSLkfmp0y7XUSxiDDx3g46Hsz+
         5YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PdnB4+DVETsuhtxt6ZrOFlXGwuc4dLlLuSMGN0xrw8=;
        b=PJg0JH2Xtdbksd28QCA0DNGd5yxh3s5qvGuYXa4jnGqbZCFE/zmw9lhE+eUS+b9Nfg
         ItJWlPTAsYFZRZWggAk1+CAKskRN0fnKm1/tQxNBYK6zjoEZHi8X4cIKkZDlm3vQFC0/
         NPFIu/IU876lBYG+H75sYl4IebhoMqFi6vMreoyD6hGQC1kgw44Sb69ZuhHSa2gvOYxd
         hTwVoDM78coz+mgKXIV7XFgZFFUc8KeYu389HM2bwIgfQOFOsJZ7kiPB485UfVKYtr9Z
         drei1089vNSI1y5Pm1ZhAHDGbmJxONgjurn2W4211772h3/+59IJUO+Poc5jm+pi2lFI
         CzgQ==
X-Gm-Message-State: APjAAAVUNMOBGtiPb+xtg/j5h2eMOzDgr5T/2CWHI2UCExV7tGu36R+j
        QKg959pyAZPvlJykEzrLGZrnov+Z5qFaoiNgENV5gg==
X-Google-Smtp-Source: APXvYqzSNjt1lYKjURaRXuVncVRWOToNmhOfLXFnEo7r8V/3u9q15MPobypEm+Fc3TnK08e+rNVdVXdF65GrsXrVICo=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr50180412lfc.60.1564308476044;
 Sun, 28 Jul 2019 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
 <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
 <4C901747-1657-47AD-A9D7-10E41AFB35CB@goldelico.com> <20190728085010.36040cb2@archlinux>
In-Reply-To: <20190728085010.36040cb2@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Jul 2019 12:07:44 +0200
Message-ID: <CACRpkdb1-d3mzJAs2AVdz3n8vWGy-cgajiTP4k=cJSqTsbgpeQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 28, 2019 at 9:50 AM Jonathan Cameron <jic23@kernel.org> wrote:

> Given the comments that 'need' any response are fairly minor, I've just
> taken the view that the perfect is the enemy of the good and applied
> it to the togreg branch of iio.git with some really small tweaks.

Oh that works, too :) whoever is most annoyed will get to fix any
remaining offenders.

The quality of documentation really depends on perspective.
This weekend I read some old UNIX System V manuals
and this was "extremly professional" documentation at one
point. It wasn't very good. I think we're pretty well off with what
we have here.

Yours,
Linus Walleij
