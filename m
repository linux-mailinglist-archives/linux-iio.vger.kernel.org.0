Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641F93D7CCC
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhG0R4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 13:56:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3506 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhG0R4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 13:56:11 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZ40y3K6mz6L9ph;
        Wed, 28 Jul 2021 01:44:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 19:56:08 +0200
Received: from localhost (10.47.8.150) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 18:56:07 +0100
Date:   Tue, 27 Jul 2021 18:55:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     kernel test robot <lkp@intel.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        <kbuild-all@lists.01.org>
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210727185541.00007369@Huawei.com>
In-Reply-To: <CANk7y0gxK5=kBYb+O1OGBAvT5qqmC4Tq=DG1H-CowEcaWC-wKg@mail.gmail.com>
References: <20210727051627.12234-3-puranjay12@gmail.com>
        <202107271937.8vfzyty1-lkp@intel.com>
        <20210727144622.00006d94@Huawei.com>
        <CANk7y0gxK5=kBYb+O1OGBAvT5qqmC4Tq=DG1H-CowEcaWC-wKg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.150]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:40:52 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> On Tue, Jul 27, 2021 at 7:16 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 27 Jul 2021 19:45:46 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >  
> > > Hi Puranjay,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on iio/togreg]
> > > [also build test WARNING on linus/master v5.14-rc3 next-20210726]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Puranjay-Mohan/iio-accel-add-support-for-ADXL355/20210727-131822
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > > config: openrisc-randconfig-s031-20210727 (attached as .config)
> > > compiler: or1k-linux-gcc (GCC) 10.3.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.3-341-g8af24329-dirty
> > >         # https://github.com/0day-ci/linux/commit/a0ad8ce87d3d3357c64f98bec48b75d07b961da8
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Puranjay-Mohan/iio-accel-add-support-for-ADXL355/20210727-131822
> > >         git checkout a0ad8ce87d3d3357c64f98bec48b75d07b961da8
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > sparse warnings: (new ones prefixed by >>)  
> > > >> drivers/iio/accel/adxl355_core.c:204:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] regval @@     got int @@  
> > >    drivers/iio/accel/adxl355_core.c:204:16: sparse:     expected restricted __be32 [usertype] regval
> > >    drivers/iio/accel/adxl355_core.c:204:16: sparse:     got int  
> > > >> drivers/iio/accel/adxl355_core.c:341:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] out @@     got int @@  
> > >    drivers/iio/accel/adxl355_core.c:341:29: sparse:     expected restricted __be16 [usertype] out
> > >    drivers/iio/accel/adxl355_core.c:341:29: sparse:     got int
> > >
> > > vim +204 drivers/iio/accel/adxl355_core.c
> > >
> > >    195
> > >    196        static int adxl355_read_axis(struct adxl355_data *data, u8 addr)
> > >    197        {
> > >    198                __be32 regval;
> > >    199                int ret;
> > >    200
> > >    201                ret = regmap_bulk_read(data->regmap, addr, data->transf_buf, 3);
> > >    202                if (ret < 0)
> > >    203                        return ret;  
> > >  > 204                regval = data->transf_buf[0] + (data->transf_buf[1] << 8)  
> > >    205                                             + (data->transf_buf[2] << 16);  
> >
> > Note that you can almost certainly use something like get_unaligned_be24(data->transf_buf)
> > here, though current code is some mixture of hand unwinding the endianness
> > and calling a standard function to do it.  
> 
> I feel doing it fully manually is fine as most other drivers are doing
> it that way. I have sent the next version which does this fully
> manually.

It's not a good idea to do it that way.

The intent of the get_unaligned_be24() and friends is to make the semantics
of what is going on clear and for those trying to review a lot of code that
is very useful.  The new code is doing something entirely different to the
above... (where did >> 4 of the least significant byte come from?)

Agreed, there are still older drivers doing this by hand and work is ongoing
to convert them over to the standard functions.

Whilst we are here it would be good to do other instances such as use
get_unaligned_be16() for the temperature channel.  In that case you'll
also give a small performance improvement on a typical big endian platform.

Jonathan

> Also, I ran it through sparse this time before sending it.
> >  
> > >    206
> > >    207                return be32_to_cpu(regval) >> 8;
> > >    208        }
> > >    209
> > >    210        static int adxl355_find_match(const int (*freq_tbl)[2], const int n,
> > >    211                                      const int val, const int val2)
> > >    212        {
> > >    213                int i;
> > >    214
> > >    215                for (i = 0; i < n; i++) {
> > >    216                        if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
> > >    217                                return i;
> > >    218                }
> > >    219
> > >    220                return -EINVAL;
> > >    221        }
> > >    222
> > >    223        static int adxl355_set_odr(struct adxl355_data *data,
> > >    224                                   enum adxl355_odr odr)
> > >    225        {
> > >    226                int ret = 0;
> > >    227
> > >    228                mutex_lock(&data->lock);
> > >    229
> > >    230                if (data->odr == odr)
> > >    231                        goto out_unlock;
> > >    232
> > >    233                ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > >    234                if (ret < 0)
> > >    235                        goto out_unlock;
> > >    236
> > >    237                ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
> > >    238                                         ADXL355_FILTER_ODR_MSK,
> > >    239                                         FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
> > >    240                if (ret < 0)
> > >    241                        goto out_unlock;
> > >    242
> > >    243                data->odr = odr;
> > >    244                adxl355_fill_3db_frequency_table(data);
> > >    245
> > >    246        out_unlock:
> > >    247                ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > >    248                mutex_unlock(&data->lock);
> > >    249                return ret;
> > >    250        }
> > >    251
> > >    252        static int adxl355_set_hpf_3db(struct adxl355_data *data,
> > >    253                                       enum adxl355_hpf_3db hpf)
> > >    254        {
> > >    255                int ret = 0;
> > >    256
> > >    257                mutex_lock(&data->lock);
> > >    258
> > >    259                if (data->hpf_3db == hpf)
> > >    260                        goto out_unlock;
> > >    261
> > >    262                ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > >    263                if (ret < 0)
> > >    264                        goto out_unlock;
> > >    265
> > >    266                ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
> > >    267                                         ADXL355_FILTER_HPF_MSK,
> > >    268                                         FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
> > >    269                if (!ret)
> > >    270                        data->hpf_3db = hpf;
> > >    271
> > >    272        out_unlock:
> > >    273                ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > >    274                mutex_unlock(&data->lock);
> > >    275                return ret;
> > >    276        }
> > >    277
> > >    278        static int adxl355_set_calibbias(struct adxl355_data *data,
> > >    279                                         int channel2, int calibbias)
> > >    280        {
> > >    281                int ret = 0;
> > >    282
> > >    283                data->transf_buf[0] = (calibbias >> 8) & 0xFF;
> > >    284                data->transf_buf[1] = calibbias & 0xFF;
> > >    285                data->transf_buf[2] = 0;
> > >    286
> > >    287                mutex_lock(&data->lock);
> > >    288
> > >    289                ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > >    290                if (ret < 0)
> > >    291                        goto out_unlock;
> > >    292
> > >    293                switch (channel2) {
> > >    294                case IIO_MOD_X:
> > >    295                        ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_X_H,
> > >    296                                                data->transf_buf, 2);
> > >    297                        if (ret < 0)
> > >    298                                goto out_unlock;
> > >    299                        data->x_calibbias = calibbias;
> > >    300                        break;
> > >    301                case IIO_MOD_Y:
> > >    302                        ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Y_H,
> > >    303                                                data->transf_buf, 2);
> > >    304                        if (ret < 0)
> > >    305                                goto out_unlock;
> > >    306                        data->y_calibbias = calibbias;
> > >    307                        break;
> > >    308                case IIO_MOD_Z:
> > >    309                        ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Z_H,
> > >    310                                                data->transf_buf, 2);
> > >    311                        if (ret < 0)
> > >    312                                goto out_unlock;
> > >    313                        data->z_calibbias = calibbias;
> > >    314                        break;
> > >    315                default:
> > >    316                        ret = -EINVAL;
> > >    317                        break;
> > >    318                }
> > >    319
> > >    320        out_unlock:
> > >    321                ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > >    322                mutex_unlock(&data->lock);
> > >    323                return ret;
> > >    324        }
> > >    325
> > >    326        static int adxl355_read_raw(struct iio_dev *indio_dev,
> > >    327                                    struct iio_chan_spec const *chan,
> > >    328                                    int *val, int *val2, long mask)
> > >    329        {
> > >    330                struct adxl355_data *data = iio_priv(indio_dev);
> > >    331                int ret;
> > >    332                __be16 out;
> > >    333
> > >    334                switch (mask) {
> > >    335                case IIO_CHAN_INFO_RAW:
> > >    336                        switch (chan->type) {
> > >    337                        case IIO_TEMP:
> > >    338                                ret = adxl355_get_temp_data(data, chan->address);
> > >    339                                if (ret < 0)
> > >    340                                        return ret;  
> > >  > 341                                out = (data->transf_buf[1] << 8) + data->transf_buf[0];  
> > >    342                                *val = be16_to_cpu(out);
> > >    343
> > >    344                                return IIO_VAL_INT;
> > >    345                        case IIO_ACCEL:
> > >    346                                ret = adxl355_read_axis(data, chan->address);
> > >    347                                if (ret < 0)
> > >    348                                        return ret;
> > >    349                                *val = sign_extend32(ret >> (chan->scan_type.shift),
> > >    350                                                     chan->scan_type.realbits - 1);
> > >    351                                return IIO_VAL_INT;
> > >    352                        default:
> > >    353                                return -EINVAL;
> > >    354                        }
> > >    355
> > >    356                case IIO_CHAN_INFO_SCALE:
> > >    357                        switch (chan->type) {
> > >    358                        case IIO_TEMP:
> > >    359                                *val = TEMP_SCALE_VAL;
> > >    360                                *val2 = TEMP_SCALE_VAL2;
> > >    361                                return IIO_VAL_INT_PLUS_MICRO;
> > >    362                        case IIO_ACCEL:
> > >    363                                *val = 0;
> > >    364                                *val2 = ADXL355_NSCALE;
> > >    365                                return IIO_VAL_INT_PLUS_NANO;
> > >    366                        default:
> > >    367                                return -EINVAL;
> > >    368                        }
> > >    369                case IIO_CHAN_INFO_OFFSET:
> > >    370                        *val = TEMP_OFFSET_VAL;
> > >    371                        *val2 = TEMP_OFFSET_VAL2;
> > >    372                        return IIO_VAL_INT_PLUS_MICRO;
> > >    373                case IIO_CHAN_INFO_CALIBBIAS:
> > >    374                        if (chan->channel2 == IIO_MOD_X)
> > >    375                                *val = data->x_calibbias;
> > >    376                        else if (chan->channel2 == IIO_MOD_Y)
> > >    377                                *val = data->y_calibbias;
> > >    378                        else
> > >    379                                *val = data->z_calibbias;
> > >    380                        *val = sign_extend32(*val, 15);
> > >    381                        return IIO_VAL_INT;
> > >    382                case IIO_CHAN_INFO_SAMP_FREQ:
> > >    383                        *val = adxl355_odr_table[data->odr][0];
> > >    384                        *val2 = adxl355_odr_table[data->odr][1];
> > >    385                        return IIO_VAL_INT_PLUS_MICRO;
> > >    386                case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > >    387                        *val = data->adxl355_hpf_3db_table[data->hpf_3db][0];
> > >    388                        *val2 = data->adxl355_hpf_3db_table[data->hpf_3db][1];
> > >    389                        return IIO_VAL_INT_PLUS_MICRO;
> > >    390                default:
> > >    391                        return -EINVAL;
> > >    392                }
> > >    393        }
> > >    394
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >  
> >  
> 
> 

