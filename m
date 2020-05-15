Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F71D4CEF
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEOLrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOLrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 07:47:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8864C061A0C
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:47:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so1879287lja.13
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2020 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IC6ZZPGRIJnMH9sjYkXLAR8FAlAKMWG/aSqy+lxhBM=;
        b=pmMhLVmkms/aEGFPJaqTEzygKog4VD8tObWpypoVdOZbhsrCwDKQrPinYp59/uxTKP
         zGuZIpjD1i7IUJhqX5R9d2MSMtlGGBnsZ4L0qss5FlqTQsBvwr7fiM/XjHcxPmwefTOV
         wqpuata5/4BoezQCy+jOF2t4rF76nrWwDh54RvPkldtR8/qpFhgjObh+Kd1x3RmfD9Jv
         S5ya21CwVF+QqXAeDh9Jh1eldSNXW3IyVKzqNA1iNPn4FF5wO2bipeJAVugQvkQodNf4
         C7tVqIthUY7GKPExScs/DJEG8M8DYUkgz2Y5Cs0ZmmAYBwOv5w/UJQ3XT2ObLbKKHNwD
         da6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IC6ZZPGRIJnMH9sjYkXLAR8FAlAKMWG/aSqy+lxhBM=;
        b=jpOF7ySdk5thYYE1vMgFo7VQMAA31f+EIcPlC1UB1vqgqBUCxQuhZ83A+zL5Xan5RT
         92E/PU+GfUvXIAdr3rzkn3OSbi6JHzSOoNA4naRxUMxF+WB/qCb+VE6her8NQaIeB1UK
         1+UX0RPBXVIF+l4bheXYX/gVe4ESqSfcEopvDdmU35q5mDM2N2GxLV+fKnkhEiPtQkvp
         7EHFrcEZiAFE8xNkCaGI6nDhTG7AVrS53gx1qMmug6B5Ze99Sdm30b8KnkqWLoovwnEC
         NJQT4Mhfn2W7IBJqdIKltGfoACITDH+n7K7cAE966zvfZgl8eO61ST49HjmawkqB92TB
         tcLw==
X-Gm-Message-State: AOAM533C+CCAacgBv+NYmxQCvJOg2zx7nUf7j1idxNWTyGgLBd2K1bjg
        CXc/PsfDb1rYKmndrJVuF48cDzd2h5NdmaSjzDUVsQ==
X-Google-Smtp-Source: ABdhPJxlcrIIyOso2g7s236yDsj3eCaQNX1y1jEmp8ycfcvQ+aR7VvmzOgIaBmXDgANWhN0eJ6z38fiT668MMvwWeHc=
X-Received: by 2002:a2e:9d5:: with SMTP id 204mr1116745ljj.168.1589543267270;
 Fri, 15 May 2020 04:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB06603F08B010828F7CBFB610A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB06603F08B010828F7CBFB610A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:47:36 +0200
Message-ID: <CACRpkdZPpF=Zi-tvDGVDoh4beNTC+LEm6QROd1-CFZXjQ1D0zQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: accel: bma180: Rename center_temp to temp_offset
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 driver is being extended to support the bma150.
> Its temperature channel is unsigned so the center_temp naming
> no longer makes.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
