Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7028C44B335
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbhKITd1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 14:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243239AbhKITd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 14:33:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000FC061764;
        Tue,  9 Nov 2021 11:30:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u11so134908lfs.1;
        Tue, 09 Nov 2021 11:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+YkNpv1b4PonXM9nQyvVMstMf5emN8fd6RkKYJ6xbA=;
        b=Y7w9fZd1xBzYopSLDZ+acrsFosOVNFsHQbB2crEl+OPUVLbkZwG1/JV6bF5M0N2Nkb
         ROdIU1MF303+NxeF5bUVINUrY7YvpxD1u7Mp2f6mZi5yJRUpgWE/pjNyxHKRo7kGmdCB
         LbLX+uxqHSH6VvFhNLQB7N9kJUoMxcZfehY8NegektFUUDKw2U+fZ/5f2mhdcGZqwXOG
         jmgrIfL5JG9u1ctq7BhI5px4RIxBNGrAf4HKmtPB2Ec366E4mccL9l8hT29MEIHftzqO
         ztPZTdP0MO5kHreeGUFsGBp+RRs8/fm0jFcsk/DkJpX7uKSywIwMfq71GXEcijkA1xMG
         IftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+YkNpv1b4PonXM9nQyvVMstMf5emN8fd6RkKYJ6xbA=;
        b=sEfOWFDMOGgq6JgynoDp+c9Wkx3H08Er5WSBrGH4Z68jlpsfHBGW/oDtNbIHg6vAsF
         EWkTLtSH6E470A1UNRJR2CC0hNKtxc6Xhqo81BwcDvCFSuxKE6BL+j2/YxBTq3SX3lxQ
         x18zgXLvKQpXG85ABSee69Sx3CHKpAa81HD3iQRfCLrEPLCr7+XFn5CT/dl58Kfibhqf
         OR2Q+wXXahI20xqRYF4NgHts7GFovWRjKwcwIMRKdqECbL+LeN7p7EgAmYXrOsdtvMmP
         OZ/P8Rs4TfNiUgwK86YAKu9LywmY1gKQ2FLulYXjyI6JODwVAUPOT+WAW8JTm1wBU2Ya
         6b5A==
X-Gm-Message-State: AOAM533TVHtQUCkeHtXdc27HXWACTYXJHCXXaixsp9SSPGlQyi50+McZ
        RZjTH+GfM5FIcqHTsxjTO74fEX9usQl69d5ZCIA=
X-Google-Smtp-Source: ABdhPJzO0SdlK4WA6Yzi59XAcAD0jMRkTGRIj/c348Vc4uYevSn6inVBOm8iVQNuWpt3uJ41lqqK2LlEKGt/KQNZfVo=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr9449254lfg.498.1636486238856;
 Tue, 09 Nov 2021 11:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20211106173909.34255-1-puranjay12@gmail.com> <YYeOVJjiz6huHv4y@kroah.com>
In-Reply-To: <YYeOVJjiz6huHv4y@kroah.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 10 Nov 2021 01:00:26 +0530
Message-ID: <CANk7y0jsy9m3YLdSgjsoP-w_NcS-QZx3UTd+jnMHdRrhQ8zgeQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] device property: Adding fwnode_irq_get_by_name()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 7, 2021 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 06, 2021 at 11:09:08PM +0530, Puranjay Mohan wrote:
> > While working on an IIO driver I was told to use of_irq_get_byname() as
> > the generic version is not available in property.c.
> > I wish to work on this and have written a function that may work.
> > I am not sure about its correctness so I am posting this patch early for
> > review.
>

Hi Greg,

> Please test your code, and also provide a user for it.  We can not take
> new functions that no one uses as that usually means they do not work.

Actually, I just wanted to get a review of this code before I test it.
Now, I have made a few changes and tested it using an IIO driver on a
raspberry pi and the sensor.
I will be posting a v2 that also includes a user of this function.

>
> thanks,
>
> greg k-h




Thanks,
Puranjay Mohan
