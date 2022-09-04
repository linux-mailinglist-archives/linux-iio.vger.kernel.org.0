Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD45AC56B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiIDQ2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 12:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiIDQ2F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 12:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E432A80
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 09:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9305E60FC7
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 16:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA79CC433D6;
        Sun,  4 Sep 2022 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308882;
        bh=jjywCTg62dVVknW2HIsLgErTX8Osi5tdmBRR5yyGa+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ELvcWc/aDITEc/wiXxZZQER5ON6GRfHQIMeg6lIm6dpPty+9pt+Yyt+IzFVZqK9FM
         G3m9jvQTr2xkNJyG3K4w68pJg0iB/hEb1WmlvNa0JyB1VgedBnSaxoBTsONGqMA1tt
         XQLBNXN8+n5RulHewinRLJHyvgwcv648X2WIRbU+kBUTAzTFVPGvcsikOuTHmtCA8W
         JECMufcZShdflxdXRE7PF0obGoDm7ieX1+OVWb32sje7PzqW1+EXku64FyCGbiZdeJ
         ZbkDBHSkDTuXdHzRQHc+eyZ//5+o7u7gt1rHPwHV49EYc3S43BllhtAIUWPw78mamP
         Zfn4/z0jqxN5w==
Date:   Sun, 4 Sep 2022 16:53:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: cdc: ad7746: Suppress false uninitialized value
 warning.
Message-ID: <20220904165356.0620c707@jic23-huawei>
In-Reply-To: <CAHp75VfjWOdgAW=YuszG5Dih_2D78YB20ShaNWVxMGjOKQhsWQ@mail.gmail.com>
References: <20220830183325.2641490-1-jic23@kernel.org>
        <CAHp75VfjWOdgAW=YuszG5Dih_2D78YB20ShaNWVxMGjOKQhsWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Aug 2022 23:04:47 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Aug 30, 2022 at 10:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Fix warning:
> > drivers/iio/cdc/ad7746.c:336:14: warning: use of uninitialized value '<unknown>' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
> > reported on linux-next.  The compiler can't see into the implementation
> > of kstrtobool() to identify that the if (ret < 0) condition is
> > sufficient to detect cases where this parameter is not initialized.  
> 
> Sorry, but to me this sounds like a false positive that provokes
> developer to add not only unneeded, but in some cases harmful code
> (yes, there were cases in the history when preinitializing variable
> with some value made a regression).
> NAK from me (but you always may overrule as a maintainer :-).
> 

I'm fine leaving it as is and exercising the delete key for any reports :)

Jonathan


