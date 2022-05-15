Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D445278CE
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiEOQuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78C2A24A;
        Sun, 15 May 2022 09:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3592961006;
        Sun, 15 May 2022 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D1C385B8;
        Sun, 15 May 2022 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652633409;
        bh=HsqtpfvtmyTVUvcUp+1tN7FgGBmtK7BHtCt/uJAWdxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1L09ulVSO0Q2zgw4NrCwr1SMoa8eF4h+APGR6wpinX1myWcEA6W4PCS6PC6vlRzy
         avRlz59hQgSuIXdVYE8t/ZSDwZ8Pk5QFzBL+xR+UILf/4Z1BVP2vEIoeE9cCgKclUJ
         H5HNoXJCGuMOc+YNLSD69rdUQ1eY7FNxvCC/4jsB2059uPdL9S1mFFQsa6rmhDoxGL
         8VvqhsiH+WR1KYvCGiakin+kngB7wlAbDmGKjL+KOS4gotGzbtWWpqfTL2j3INh7Yn
         8+jVpWjKY75hP5ECYd+nm1jMdZmS9eDGLjWHoM1jJ/vbIcRVhUOvPSxsggU2dUC8BS
         sbO+IbaYDwJrQ==
Date:   Sun, 15 May 2022 17:58:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/7] iio: adc: qcom-spmi-adc5: Add missing
 VCOIN/AMUX_THM3/GPIO# channels
Message-ID: <20220515175843.04ca5c51@jic23-huawei>
In-Reply-To: <20220515175714.20369e91@jic23-huawei>
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
        <20220511220613.1015472-5-marijn.suijten@somainline.org>
        <20220514171312.227a1f07@jic23-huawei>
        <20220515153004.iniplpuf6g5ibvjw@SoMainline.org>
        <20220515175714.20369e91@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 May 2022 17:57:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 15 May 2022 17:30:04 +0200
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2022-05-14 17:13:12, Jonathan Cameron wrote:  
> > > On Thu, 12 May 2022 00:06:10 +0200
> > > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> > >     
> > > > These channels are specified in downstream kernels [1] and actively used
> > > > by ie. the Sony Seine platform on the SM6125 SoC.    
> > > 
> > > Looking at the links, some of them are on that platform but not all.
> > > Better to make that explicit in this description.    
> > 
> > This has already been queued up for v2.  Adding these seemed easy at the
> > time but they are in fact not used, and I ended up sending the wrong
> > patch.
> > 
> > Just so that we're on the same page: only ADC5_AMUX_THM3 and
> > ADC5_GPIO2_100K_PU are unused by my platform.  It seems the first should
> > be dropped, but the latter can probably stay in the patch with an
> > explicit mention.  If you think both should stay, there are a bunch more
> > channels defined in the downstream kernel as per [1] and I'm not sure if
> > all should be added for completeness.  
> 
> Probably better to add them with a comment for platforms on which they
> apply (either in commit log or alongside the definitions in the code).
By 'them' I mean add the ones used on your platform only.  Let others
add theirs when / if boards using them are upstreamed.

(realised I'd been very unclear just after hitting send!)


> 
> Longer term we should think about whether the code can be adjusted
> to not need an explicit definition for these multi purpose channels
> though letting the dt itself describe them (under constraints of the
> hardware platform).  Not worth doing before this patch though.
> 
> >   
> > > > 
> > > > [1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688
> > > > 
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>    
> > > 
> > > I'm not keen on patches with no context being
> > > sent to mailing lists. Please cc all lists (and preferably individuals)
> > > on at least the cover letter so we can see overall discussion.    
> > 
> > That can be attributed to the terrible workflow for sending
> > patch-series.  Somehow only `git send-email` supports --cc-cmd yet I'd
> > expect it on `git format-patch` for auditing and possibly copying to the
> > cover letter, if `git format-patch --cover-letter` couldn't do this from
> > the beginning.  
> 
> It would definitely be nice as an option.  Can't do it every time because
> on tree wide change the cc list can become so large the mailing lists
> reject it.
> 
> > At the same time `git send-email` has --[to/cc]-cover options to
> > propagate email addresses from the cover letter to all the individual
> > patch-replies, but not the inverse :(
> > 
> > In the end this leaves me manually running get_maintainer.pl over the
> > entire formatted patch-series, and manually copy-pasting + editing the
> > addresses into the cover letter... Which is easy to forget and is no
> > different here.
> > 
> > My apologies for (yet again) accidentally not sending at least the cover
> > letter to everyone.  That's a gross oversight, and I'm probably - no, I
> > must - be doing something wrong.  Suggestions and/or documentation
> > references are welcome.  
> 
> Andy Shevchenko has some scripts to try and help with this:
> https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 
> I've not started using them myself (not gotten around to it yet!) but
> he's pointed to them when I've missed people from cover letter cc lists
> in the past.
> 
> >   
> > > If nothing else, I've no idea if intent is that the patches go through different
> > > trees or all need to merge via one route.    
> > 
> > I have no idea either, and have not yet had an answer to a similar
> > question on a different list.  Usually it seems the maintainers work out
> > amongst themselves who picks what patch, putting them on hold where
> > necessary to preseve ordering.  If not, should the sender split patches
> > across multiple series, either holding off sending part of it or linking
> > to a dependent series?  
> 
> In this case I think I can pick this patch up directly into the IIO tree
> once everyone else is happy. As you note dts patches normally wait on
> knowing the necessary support is heading in.  If you have a view on what
> makes sense as the submitter it's good to stick it in the cover letter, but
> in this case sounds like you don't. :)
> 
> Given we are near the end of this cycle, we are probably looking at next
> cycle anyway now, so plenty of time to figure it out!
> 
> > 
> > In this particular case DT has to wait for these driver patches to land,
> > otherwise they may define channels that do not exist and unnecessarily
> > fail probe.
> >   
> > > Patch itself looks fine,    
> > 
> > Thanks.
> > 
> > Looking forward to your suggestions and answers,
> > 
> > - Marijn
> >   
> > > [..]    
> 

