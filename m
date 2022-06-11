Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170845477AB
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiFKVTl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 17:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiFKVTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 17:19:41 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044065638E
        for <linux-iio@vger.kernel.org>; Sat, 11 Jun 2022 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654982378; bh=88/mIeI7cjZXJiQxnupSL+lAMglf4mE/oS/Wtk2GnyM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=k+lyvOzZ+wIUOBQZbaFRdIaWvtTB6QFppo0TkiaKfglNMfu2ggVR01A9jOXHQZIA2to8xRWLbKIfhoL7HWMjqU1UKHJuQXdSqOF8GSSNdCCMKxIALkcTz5Kgb5T94AB9S0JWJ3J8R2oXbTvCs2iJ1K/pGk1smKPTXUkxHSt1purMMPkf29eqzg3DPip1A50OBGd6UmEI72pp6Bi8ZYAS2yDzoQHC+mOsJW4u9AdYYSzQL2mDcYlQ7m642swQfGwow9YeZE8iV62q10NJxrA3eh5KvM8n/zTpAlziuedlFsjcZLcuB0cwmb3+G2k7PPkv735B2AwsCBo3s4MWk+Gjzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654982378; bh=3eoRNJ6XEq7IcFeJLzFzwHNkIYjKMUWMjfT8IcAjNN7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BKdsGGugw4LAQ5xkT3N3viHD2Nav/tJ/TpMD2LQMUo1CI36Ym57Qnr9acwvMnYE1w+E5zIbe4YeT7BOEuLxqYOHVZKyHrNJ1W9Uiz04k6qNBDGfqugGGepH1vB0RUP2+f2cdGziv53CU9qt/NsbVdeYjKqeC21zcp+E5LLGvvzXCdI50+V3DYjJPC0rxmwlEtw/C733PEd27eT3gkG1/1D+mgHDfwwsF/7960r216x7ZMnuBA3wFo3RoA9zUHvmcoU8QeAi3B2VAOxyFJV4gYzjvNA5222QhOzG1oAvh134MeQ0EiD+Bp+mc7/FjpirWrgQZsG3ZNwz17CT8EVMbsA==
X-YMail-OSG: WEBwJ3MVM1lAhonfPYXxZDmzLwPQVWNxBsAa_Xe_EfLcljmpILR0z6NZuIC1XWD
 hFCqpArry3zppZCjFUmxypzPsi8xzt2pmRX7XPG8qI2n2qjBr_qLxyRwhPC7A.dvZicqHvyiCe4r
 QNk7L80IxxVwbFQFq.6_rrd3nXDilKmOeiTxvD3cE0Ms6PTw3Crk6Ihb5OUTthP1BisFXnurTWtR
 ModCWU1yK4wyRPQXuP3wTxwesSO1nYr3UTHkcpRuUdagC.g8ERB0DgNToiy7c6CfYu5.IircEAIP
 NW_oPH5asn1Ns_8Dk4pIannjjFLCs3SXhD5zqWaix41W0zWuYW.sop488zmEk3R.NsyPncfYAQfe
 IxYtlNmBcJQeh4764OSj8DHkPnpTQJvnUOt0WKOEaTkeor_uccbnqq_e0W.O2QtmTh3SeEMsQWAe
 UGkTMssjVdx9Csf3iBY4rvmjv87JyIp_Miw_8EGu4bA6V.uca_bWriAc9KhKaWMKN7F_C_EvQfKS
 0DcSzzbgBLI3q1fU0YMbM_2Z.VUmH2TtdFoldSPY8dI4CpElwkA0Bg.lZGKQZwRE.f4DZ71S71N0
 vLXzSP4y29d56GawzjmKjwMyIDlhZ7oK51Za3Z.kFs.064_cBRT1J_s0q8rKHKomDc4TM.1AyICt
 TMB5xeQIK_iWsAJH4F7Ct5Dp6A95PKMH1nDIjLdxGPaGaDxBACvXy91Y8cxx8yreW9YzS88Vcoc7
 0PzXGrnT.w_DGpzgegVfT3GCc02ShsPso091JsI.9bh7.ZbigEJzenleQyd6zNtg_TmZ1ge7yT8A
 MhPbi4pmqHTJuFiI9bWE1xbmje_KqiOZYfY_gX5nvZrsmJepJK7u1Y2eq4WmYE1vGiCwEgjt_2pr
 yhst0NcRNhmw7fkQS0ua2VorzoaeSvZGsIxWtxmav8209pQLzdkadNL2oU.m1PpmCRNShn4Jh.z0
 xaM._AGUV6kAfpabrgsanhPVY7pFa9sqymfAPm4KpkLUxfFbd.KroIJpgNKtvROTTWdTueVKwqMi
 5MmMCdplawQYdhNYfQ16H0s.d2KXGxWIqjWEJFK7GCxJbgjEUpwQOyq8Yqu_PcNX.5dtHpX.z.xq
 A8a_W8CNJEHXfkWK5g7dgTmmmzUirXi1iW0CraJLFSW2BXe7RFniUiJ3VzX9CNpTSSbTc3Cf0giE
 u8Lt96jFCEW8n4fY8Y7h3AvQ1.wlt_ehWuUow8qp6FkMnM.4800PB8kN1DEjetQB2lpcvzU_emtA
 iQy8xXgtAehRzAZil03VEl5T8Pmn5KhV0uF3W1E0.rqb4KlPVpSH_JHJNqrpgaw_yb_e8S2NJ1.Q
 .PFUQZ_7Qy5U7xXZ34WKbcK776tflCHYZzcH7n3_VcRsa8V2.dw.SKrA22WkCjwamUV5oPOOWCTf
 3y2dTqPfbh2MPmzE84OUz7w4CMIWzvp7z98W5c54oSrCLQWwwNouplkBu4hEnT89mHlWVIrEv1Cs
 1LFDvngGi4tEyT30hJYK65be2he80C232u6xX.5RJHsLD2c2ZCJWlCegJfiWuwK5WPad7m7yKq9p
 VhB.8.ThNXr6qtjCiVjRCeFM9MzQZUQCHIW.iz_5ELmHVUb16AGHDS.gKWHuVtSTgceWoGIp8FDX
 2dfA0atgBM3npl8RZ6.Th3ekLsEfH4wVNQRjkrn_wk1hpx0UWh2Vk8TKCGM4djCHfppNmmrPXK69
 PmaH_eu_1Y_KES9QoxGpEbmFDPq5Bihi2RU5tqk3xc9Z3kXcWGMxtNefS0p4IGRdxfiI0Ozr5adI
 ajnEooz9KBXrwO3SKB.6raCUnZzzEH8lL87MhNyTWQvVY_8pWQSj9dmxgb7bjye95pIeGyMk12Fk
 gA4gbVPJt9dYZkV8s4HYS.th7FW4ys9eyKeVEh7ptTym4Iu1DWv3px0QUcYgPTsgcWYAiiCJHvZF
 4qMyu2i.w6_jZzxsPjc25eoRBEqdtLs6Zf4uSM4.lmqTafewnLjeFEPqVnbW50ezcE2kWEaQVInX
 BkNJnqwy3x2zFfhjWDUF_.2hg0sVa9mf8k3utxlIUwT91.0x7TwFxGOOB.BW0Oi_Wq5L4VJADAsB
 kLYRXK47GeP7tDpEeUwrcxaTkHA.evZAUgGQEbG7_fjLq8yjKO5oOQRgqTfSuGlLYUa5KTPjdw8Z
 TWGMKlqMgA91lkpYiSPQeFc411nuRmmNUXfWJCdzAaYnF7lcC7uUnWAf84xgIdcK1czebplFB4n1
 B0jyD37hyJ9EGjNmUuuAcbiQBn3ghYoy.3FZ7JZa53Y4j1OB25Xs3fv5XtogMCwowh_0PuhsAE9q
 siy00n3A0wifdMqz7lNpGvfeUfkyr5MQMO1PC.44ZBTkPOCulkv9o5Ys0PJz3VEC6JqQhtqA5rDA
 5PmmVtnYwmoWufTXKbP4e0BRgbsz.Jffa8ZHCzq0JCKt_4F479MUh
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sat, 11 Jun 2022 21:19:38 +0000
Received: by hermes--canary-production-ir2-6c7595c778-pmqqk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 380c144581fc6a504b05c1fb6a9bfbc3;
          Sat, 11 Jun 2022 21:19:34 +0000 (UTC)
Message-ID: <9215e460-9655-dd70-8fdd-8572efddb40b@rocketmail.com>
Date:   Sat, 11 Jun 2022 23:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1654727058.git.jahau@rocketmail.com>
 <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
 <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com>
 <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com>
 <CAHp75VeprMCdP_HqcVUhQow_OStKDMF4c2k5s1gs7RwOTzO=FQ@mail.gmail.com>
 <7265c507-b32d-c2e3-d9ca-876d9382a8e8@rocketmail.com>
 <CAHp75VfV1E1WaLVDG3V9460AsVxahb9Epod-63T35eDV+h8Ubg@mail.gmail.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CAHp75VfV1E1WaLVDG3V9460AsVxahb9Epod-63T35eDV+h8Ubg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 11.06.22 22:22, Andy Shevchenko wrote:
>
> On Sat, Jun 11, 2022 at 4:00 PM Jakob Hauser <jahau@rocketmail.com> wrote:
>>
>> (Side note: There is something wrong with the Cc list in your e-mail,
>> the list of addresses isn't handled correctly.)
> 
> The list is the same as in your mail. Dunno what exactly is the
> problem you are referring to?

It somehow got confused by the colon after "open list" and the tilde
before "postmarketos". Everything in between got interpreted as the
name/description of the postmarketos mailing list. Your first reply at
2022-06-10 14:31 didn't make it to the devicetree list and likely not to
Hans. Since then, these addresses show up twice in the thread, once for
real and once still interpreted as name/description of the postmarketos
mailing list.

The thread in the devicetree list:
https://lore.kernel.org/linux-devicetree/CAHp75VfV1E1WaLVDG3V9460AsVxahb9Epod-63T35eDV+h8Ubg@mail.gmail.com/T/#t

On the patchset, I'll send v2 probably at Sunday or Monday.

Kind regards,
Jakob
