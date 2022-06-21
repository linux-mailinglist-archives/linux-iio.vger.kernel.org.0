Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738A15528CC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiFUAyH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiFUAyG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:54:06 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F85814094
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655772843; bh=tn8S9AiXBwxUU2IsyguWin1Y1DPF2sNYZL/sFfs6SWw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VhoYeoxAoOrqO3KIksNPR8Kmnakgg1m8PoHFG02Brn1hWUndTISIc3V/QqcTbrfmDgn3Sq4lKXbbNaDlmVYkiDNY8jHfl1PgT2JCyTnxehk1o3IXyzTYDWEVMVvu5jhsQdICluqoqjU4K+YjNztOR2suOs8yTWTqKG5e9Zh3pULF5Vdjp7AW3Ti3M03nMp+9M/L+V5o7YGkPZqD0ecUIXaxUQO7etZ7h1B48/Awadc7NI9rzu5vyV6UdgG7ylvrStnF6fg0kRSh0WXhxuukFf39f0tWwxfOdmdbTglbaUBZIm+9hkfYF9DTYJ9QCTnG5J2UirLV7ZVruQ2uvpZnGwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655772843; bh=ALAhLTgdX5auplMRmr4u5uf7+1XVSzpSls0cC2oq2Py=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZJ+0mcZrVebIKoGZ+ZpwORd28w9hgKPCHlDr/Al77IoOYGT5w2ADNkmTiXlF4Hx0omt/Yt7GP91ZM7AyppX7WZlgfWcmQhmZ9WX0m6QJ4YuO6A96cuEi1hrFtlbpRIElRUHSyd73S7v5P76aJXdHLWAcX7g3bky3SMTLJ01fNGWvKTsM0+3icLtz32kD5itS/RYfQdZlehOxV1PWugJ+n9CMaF/GQKqNkrx1ZNq9IR9KSEmotm/yuEVednKrkauZwaAca7wvN8tHNEwR7F4k3wZOR/OfDFrDhz1nt08+gTdPGsnp9Hkt+2Udl168cDJ7XDijTZ/56K864drVwRmf4g==
X-YMail-OSG: 3_PxdSYVM1mvPFnkJ.lXGiIXi4Gl3BuLY8Mh2StvDnC4wTaRcn43J8hbGsz5wMn
 lXNxN2BZh3nhcc0rK2ZQ3E2b.6KR5PCbX3uKFWjaEn1ILCyR.hW9n6YIt5CnF_w8mTK2jfl3ujpU
 m9hpbwgA7_I6PTyEae7lTraCHWusBG6cDgfgql_TNIgWiB3FX8jW71BFKL0Bf03aoJyHqCRvbAQt
 ItQGl2WqURGAn41lbU5Kgwlkf.CA8_RUU0n7a.9IrEe024dyXjonJo5SIl87nwHnWoxjLrcJehbf
 3bXnyq9iaO4ytJxZdMpDnu.l_pEWNvY.pf92062NS0vplMw0mW8FmFrXBlfgTC63x_gg9R_sz59J
 Yab4eDernkAiXbISL1JS2AdqcsoQgdKrXUyfEMzOkZwcxcLoF6Y6dQghKApHsZr2jVl08suKGkcV
 B03UaMyeek9IoIJUJGsk6JyLkpRZRJHjkYGz77BKbPIWdn_JBhmR9j6X351cXS3CGYnRYcZgplqj
 lxbFzhsoW4n1umZBs1xLls4qx.yfoT.CzAfK0HLajZXVFSqmm4b7jLLJknPGmKTapkzcPwbrO6U0
 IprXlYPf8BoT3croG8BOCD2R0ug7cxK45mwuLZhgdEpOQPjr.mk_BqjYhFDsBaiZkgmVc5iKccer
 e6UAuhwK3mXIit6eIfK9CACEuZyjBv4iMObtt092JK.XQ.DlYwfmsgC4MMQ6wZKwKsihjWmqDL95
 5BiqXQIhFek4raP18uWu1A_8p7LGPitugcBcMg5noPRWABdUEJIBOZnbEEoyDVz_7rUx6lP7k9HG
 O1QcHJzMtNgJ981.y0tI4QPX1rkwbQ1hoV3TINB4BNG8oRRNGzxiwdYQQYpwca7RdTp79Or4V2T1
 sAJVpH47FwWZSTeq6gb1YEXgaE8V8kuaL2t6xxPcN5.Vvc92zcvv_Nylkh931iNA8uPIBple3pYG
 VT_29KaCEBQBKZjpPhyrMBaANaU4k8BhRASdDoLqmLs_pU4UBx3v.s_ZiLpWuxcq1Ddjl4txEW_T
 nWIegLjj96lHsIa.yxo5BlJSK2L9GyQqDHb58dBOdqo_rEjtQVZp..gPRMLey8U3AkF2sTOvAwCp
 eXCzgNYtNoRyTmBhEov0Cp9.icMvM17rxnQerOGosKiXU_6Jt4484F2PT0QTNl398MdOn5a0cgH3
 ztphI453rYj7fXZHvuw5OA9J.mtfaw7OlvfoAhYpjrjyAG.lTLjqdm6LiwNMO7flgnLRctl6m6vG
 aWVl69_uxG77OhRF7rPivl7DnBaheLUGx_guy9fUJfwdFM89CoArBIpPg2gL9USfwksM_kNsOwYz
 zDeP86KbOiiBj6eGL4lRoaPFRrx4A_siGC_wNLNs2TGnfysg.Da87P.QTtBj9vkTtsrhrhTa4764
 XATAziQ_CMIveMaGGmr7kaIcIjgCtyEZn3vigVtMLlIrYcKekXzw9qBVw3iwoNjZl5GmNxkwBphJ
 eBOwBKQVO7sufZsVnhZk06D71J4pbHi4YF2h_0IQTywu2.u0.wcJl0IN2urezaZx9I8PZpCqxRXL
 NTZG8en7fdmH2mt8O5uzRY8mG9N7CIVDaOng9bFmJHjX6ayhUsgW_Oy6KS_N.NUIOyffkbuD6LrX
 UqSie6fME09.fGtYScwJKBHWICcDahXKJtPnaZkvizB2NOMVmAykzDx62QY8TXvGmu6.Szoq13gX
 F93cjTdqTI.w6FQyepIn7AfxstkGzXrOPsl98d_ahRDakgdWh3KCwPpXyb26g15ZfzbXEAf.An75
 Vx1pHDfIrZ4Arusp2m_5yYnc5hwMT8angkgBkemxsCHlChZ3Us7IUIRcbfCIa1D16eHcElMuAh6k
 dJu4x9OxBGA2dqRyksyakOOEgFKVWZJp7qFpSf1B.HouqmDU4rJCTSTXL7jNQv50NTvNu.5ly4_K
 UBcl3gRGt7oD9ramqHMHHBcQEXpRzXLmnIVv_4eIov2k2pWUtiuBlS05n2_hjjhsgk5AmDiwNobN
 yrbLcga_c9l1MGdTllgGe028x9U.ltGt5xHGC5haR_PdNNCr3__wAP7KmJDo0yC546U9DSqUJczE
 ReW8TZfz0IQgWfKtCak_kVTAHpNU7yHQVkKpnDDJZidGNyaTj8.yBGHyxc2GDMsZpUeOypM6a.Zv
 gV53eoeEde9XIUASvZTArSyP5m8.NbBoM7p6arXhn0NgDbx0gB3WV.pwxlpkHuiDnemrjdKBs1OP
 THDnSP9QOWxAtRDTRTmfo_emZEhdlwUnv_m538TDxo9tyQkoQddAIGJIcGNjYQftRlESQtr4xhAG
 7SNA-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:54:03 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-nqj52 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 630878d556ed28c802b7ae82a6527450;
          Tue, 21 Jun 2022 00:54:00 +0000 (UTC)
Message-ID: <d3e074b8-9679-87fe-dc5a-9493f0586aca@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and
 registers
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
 <20220618160041.15798dcd@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618160041.15798dcd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18.06.22 17:00, Jonathan Cameron wrote:
>
> On Sat, 18 Jun 2022 02:13:14 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
> 
>> This is a preparation for adding YAS537 variant.
>>
>> Rename functions used only by YAS530 & YAS532 from yas5xx to yas530_532.
> 
> We've been bitten in the past by naming choices like this, so please
> use yas530 only and rely on comments or code that makes it obvious that
> it applies to the yas532 as well.

Hm, ok. It's harder to keep the overview. But I can imagine adding up
names can get out of control. I'll change it.

For functions and registers used by all variants, I'd keep yas5xx or
YAS5XX respectively. I hope that's ok.

Again I'm not sure on the "Reviewed-by:" tags. Again the patch gets
modified a lot, therefore I would remove the tags.

...

Kind regards,
Jakob
